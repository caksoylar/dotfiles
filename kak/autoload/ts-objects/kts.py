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


import sys
from argparse import ArgumentParser
from pathlib import Path

from tree_sitter import Language, Parser


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


def main():
    """Parse args and find the objects."""
    ap = ArgumentParser()
    ap.add_argument("language", choices=["python", "yaml", "json", "c"])
    ap.add_argument(
        "object", choices=["function", "class", "test", "parameter", "comment", "entry"]
    )
    ap.add_argument("extent", choices=["inside", "around"])
    ap.add_argument("cursor_bytes", type=int, nargs="+")

    args = ap.parse_args()
    source = sys.stdin.read()

    ts_lang, queries = get_parser_and_queries(args.language)

    parser = Parser(ts_lang)
    ts_queries = ts_lang.query(queries)
    tree = parser.parse(source.encode("utf-8"))

    tag = f"{args.object}.{args.extent}"
    if "@" + tag not in queries:
        sys.stderr.write(f"kts.py: Tag {tag} not supported for {args.language}\n")
        return

    captures = ts_queries.captures(tree.root_node)

    capture_boundaries = []
    for cursor_byte in args.cursor_bytes:
        for capture in captures.get(tag, []):
            if capture.start_byte <= cursor_byte <= capture.end_byte:
                capture_boundaries.append((capture.start_point, capture.end_point))
                break
        else:
            sys.stderr.write(f"kts.py: No capture found for {tag} around {cursor_byte}\n")
    if capture_boundaries:
        print("select", end="")
    for start, end in capture_boundaries:
        print(
            f" {start.row + 1}.{start.column + 1},{end.row + 1}.{end.column + 1}",
            end="",
        )


if __name__ == "__main__":
    main()
