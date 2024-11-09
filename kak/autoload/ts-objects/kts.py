"""Simple tree-sitter helper for Kakoune object selections."""

# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "tree-sitter",
#     "tree-sitter-c",
#     "tree-sitter-json",
#     "tree-sitter-python",
#     "tree-sitter-yaml",
# ]
# ///


import os
import sys
from argparse import ArgumentParser
from pathlib import Path

from tree_sitter import Language, Parser, Node, Point

# in loose (non-strict) mode, the movements don't obey all Kakoune objects rules.
# namely, if you aren't inside an object already then it can find the next valid object instead
LOOSE_MODE = os.environ.get("KTS_LOOSE", "false") == "true"


def get_parser_and_queries(language: str) -> tuple[Language, str]:
    """Construct the TS parser and fetch the object queries for given language string."""

    def get_queries(lang: str) -> str:
        file_path = Path(__file__).parent / "queries" / (lang + ".scm")
        if not file_path.exists():
            raise RuntimeError(f"Cannot find queries for {lang}")
        with open(file_path, encoding="utf-8") as f:
            return f.read()

    match language:
        case "python":
            try:
                import tree_sitter_python as ts  # pylint: disable=import-outside-toplevel
            except ImportError as exc:
                raise RuntimeError(f"Could not import bindings for language {language}") from exc
            ts_lang = Language(ts.language())
        case "yaml":
            try:
                import tree_sitter_yaml as ts  # pylint: disable=import-outside-toplevel
            except ImportError as exc:
                raise RuntimeError(f"Could not import bindings for language {language}") from exc
            ts_lang = Language(ts.language())
        case "json":
            try:
                import tree_sitter_json as ts  # pylint: disable=import-outside-toplevel
            except ImportError as exc:
                raise RuntimeError(f"Could not import bindings for language {language}") from exc
            ts_lang = Language(ts.language())
        case "c":
            try:
                import tree_sitter_c as ts  # pylint: disable=import-outside-toplevel
            except ImportError as exc:
                raise RuntimeError(f"Could not import bindings for language {language}") from exc
            ts_lang = Language(ts.language())
        case _:
            raise ValueError(f"{language} not a supported language")

    return ts_lang, get_queries(language)


def get_captures(language: str, source: str, obj: str, extent: str) -> tuple[list[Node], str]:
    """Find all nodes matching a capture with the @obj.extent tag."""

    ts_lang, queries = get_parser_and_queries(language)

    tag = f"{obj}.{extent}"
    if "@" + tag not in queries:
        sys.stderr.write(f"kts.py: Tag {tag} not supported for {language}\n")
        return [], tag

    parser = Parser(ts_lang)
    ts_queries = ts_lang.query(queries)
    tree = parser.parse(source.encode("utf-8"))
    return ts_queries.captures(tree.root_node).get(tag, []), tag


def find_best_node(to_end: bool, cursor: int, nodes: list[Node]) -> tuple[list[Node] | None, bool]:
    """
    For a coordinate at byte offset `cursor`, find the "nearest" node among `nodes`.
    This will be the smallest node that either contains the cursor or the next/previous
    node depending on `to_end`. Also return whether cursor is inside the found node.
    """
    candidates = [
        node for node in nodes if (node.end_byte >= cursor if to_end else node.start_byte <= cursor)
    ]
    if not candidates:
        return None, False

    if to_end:
        containing_node = max(
            (node for node in candidates if node.start_byte <= cursor),
            key=lambda node: node.start_byte,
            default=None,
        )
    else:
        containing_node = min(
            (node for node in candidates if node.end_byte >= cursor),
            key=lambda node: node.end_byte,
            default=None,
        )
    if containing_node is not None:  # cursor is inside a node
        return containing_node, True

    if not LOOSE_MODE:  # if not inside a node, fail in strict mode
        return None, False

    # cursor not in a node, find closest node after/before cursor
    if to_end:
        return min(candidates, key=lambda node: node.start_byte), False
    return max(candidates, key=lambda node: node.end_byte), False


def get_new_selection(
    selection: str, node: Node | None, inside: bool, extend: bool, to_begin: bool, to_end: bool
) -> str:
    """
    Given current selection, captured node, selection mode and boundary flags, return a kak-style
    selection description for the new selection.
    """
    if node is None:
        return selection

    start, end = node.start_point, node.end_point
    if end.column > 0:  # tree-sitter end points are exclusive
        end = Point(end.row, end.column - 1)
    else:
        end = Point(end.row - 1, end.column)

    def p2c(point: Point) -> str:
        return f"{point.row + 1}.{point.column + 1}"

    if to_begin and to_end:  # select object mode (<a-i>, <a-a>)
        return f"{p2c(start)},{p2c(end)}"

    anchor, cursor = selection.split(",", maxsplit=1)
    if inside:
        new_anchor = anchor if extend else cursor
    else:
        new_anchor = p2c(end) if to_begin else p2c(start)
    new_cursor = p2c(start) if to_begin else p2c(end)
    return f"{new_anchor},{new_cursor}"


def main():
    """Parse args and find the objects."""
    ap = ArgumentParser()
    ap.add_argument("language", choices=["python", "yaml", "json", "c"])
    ap.add_argument(
        "object", choices=["function", "class", "test", "parameter", "comment", "entry"]
    )
    ap.add_argument("object_flags")
    ap.add_argument("select_mode", choices=["replace", "extend"])
    ap.add_argument("cursor_bytes", type=int, nargs="+")

    args = ap.parse_args()
    source = sys.stdin.read()

    current_selections = os.environ.get("kak_selections_desc").split()
    assert len(current_selections) == len(args.cursor_bytes)

    object_flags = args.object_flags.split("|")
    extent = "inside" if "inner" in object_flags else "around"
    to_begin, to_end = "to_begin" in object_flags, "to_end" in object_flags
    assert to_begin or to_end

    captures, tag = get_captures(args.language, source, args.object, extent)
    capture_nodes = []
    for cursor_byte in args.cursor_bytes:
        try:
            node, inside = find_best_node(to_end, cursor_byte, captures)
        except StopIteration:
            sys.stderr.write(f"kts.py: No appropriate capture found for {tag}\n")
            node, inside = None, False
        capture_nodes.append((node, inside))

    if any(node for node, inside in capture_nodes):
        print("select", end="")
    else:
        print('fail "kts: no selections remaining"')
    for selection, (node, inside) in zip(current_selections, capture_nodes):
        print(" ", end="")
        print(
            get_new_selection(selection, node, inside, args.select_mode == "extend", to_begin, to_end),
            end="",
        )


if __name__ == "__main__":
    main()
