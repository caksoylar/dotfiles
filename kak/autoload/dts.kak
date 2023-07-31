hook global BufCreate .*[.](dts|dtsi|keymap) %{
    set-option buffer filetype dts
}

hook global WinSetOption filetype=dts %{
    require-module dts

    set-option window comment_block_begin '/*'
    set-option window comment_block_end '*/'
    set-option window comment_line '//'

}

hook -group dts-highlight global WinSetOption filetype=dts %{
    add-highlighter window/dts ref dts
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/dts }
}

provide-module dts %{
    # https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.html
    add-highlighter shared/dts regions
    add-highlighter shared/dts/code default-region group
    add-highlighter shared/dts/comment region '//' '$' fill comment
    add-highlighter shared/dts/block_comment region '/\*' '\*/' fill comment
    add-highlighter shared/dts/macro region '#' '$' fill function

    # /directive/
    add-highlighter shared/dts/code/ regex '/([a-zA-Z][^\n/]*)/' 0:keyword

    # creating another region of regions
    # so that properties with '#' in their name are not considered preprocessor macros
    # for example '#address-cells = <1>;'
    add-highlighter shared/dts/node region -match-capture -recurse '\{' '\{' '\}' regions # }
    add-highlighter shared/dts/node/string region '"' '"' fill string
    add-highlighter shared/dts/node/bin_property region '\[' '\]' fill value
    # add-highlighter shared/dts/node/array region '<' '>' fill value

    # TODO how to use the previous definition of comments globally?
    add-highlighter shared/dts/node/comment region '//' '$' fill comment
    add-highlighter shared/dts/node/block_comment region '/\*' '\*/' fill comment

    add-highlighter shared/dts/node/code default-region group
    # node-name[@unit-address] { ... }
    add-highlighter shared/dts/node/code/ regex '([a-zA-Z][\w\.,+-]*)(@[0-9,\.a-zA-Z-]+)?[\s]*\{[\}]*' 1:function 2:attribute
    # &node-reference
    add-highlighter shared/dts/node/code/ regex '(&[a-zA-Z][\w\.,+-]*)' 1:meta
    # label:
    add-highlighter shared/dts/node/code/ regex '([a-zA-Z_][a-zA-Z0-9_]*):' 1:title
    # TODO how to use the previous definition of directive globally?
    # /directive/
    add-highlighter shared/dts/node/code/ regex '/([a-zA-Z][^\n/]*)/' 0:keyword
}

