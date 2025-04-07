# Setting up all the highlighters for this syntax
# could be expensive, so we'll define them inside a module
# that won't be loaded until we need it.
#
# Because this module might contain a bunch of regexes with
# unbalanced grouping symbols, we'll use some other character
# as a delimiter.
provide-module kqlsyntax %🤔
    # Define our highlighters in the shared namespace,
    # so we can link them later.
    add-highlighter shared/kqlsyntax regions

    # A region from a `#` to the end of the line is a comment.
    add-highlighter shared/kqlsyntax/ region '//' '\n' fill comment

    # A region starting and ending with a double-quote
    # is a group of highlighters.
    add-highlighter shared/kqlsyntax/dqstring region '"' '"' group
    add-highlighter shared/kqlsyntax/sqstring region "'" "'" group

    # By default, a double-quoted string is string-coloured.
    add-highlighter shared/kqlsyntax/dqstring/ fill string
    add-highlighter shared/kqlsyntax/sqstring/ fill string

    # Some backslash-escaped characters are effectively keywords,
    # but most are errors.
    add-highlighter shared/kqlsyntax/dqstring/ \
        regex (\\[\\abefhnrtv\n])|(\\.) 1:keyword 2:Error

    # Everything outside a region is a group of highlighters.
    add-highlighter shared/kqlsyntax/other default-region group

    # Numbers
    add-highlighter shared/kqlsyntax/other/ \
        regex \b((0[xX][0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?)(L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b 0:value

    # Constants
    add-highlighter shared/kqlsyntax/other/ \
        regex true|false|null|\* 0:value

    # Keywords
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(by|from|of|to|step|with|invoke|as)\b 0:keyword

    # Table operators
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(consume|count|distinct|evaluate|extend|externaldata|find|fork|getschema|join|lookup|make-series|mv-apply|mv-expand|project-away|project-keep|project-rename|project-reorder|project|parse|parse-where|parse-kv|partition|print|reduce|render|scan|search|serialize|shuffle|summarize|top-nested|union|where|sort|order|take|limit)\b \
        0:keyword

    # Scalar functions
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(abs|acos|around|array_concat|array_iff|array_index_of|array_length|array_reverse|array_rotate_left|array_rotate_right|array_shift_left|array_shift_right|array_slice|array_sort_asc|array_sort_desc|array_split|array_sum|asin|assert|atan2|atan|bag_has_key|bag_keys|bag_merge|bag_remove_keys|base64_decode_toarray|base64_decode_tostring|base64_decode_toguid|base64_encode_fromarray|base64_encode_tostring|base64_encode_fromguid|beta_cdf|beta_inv|beta_pdf|bin_at|bin_auto|case|ceiling|coalesce|column_ifexists|convert_angle|convert_energy|convert_force|convert_length|convert_mass|convert_speed|convert_temperature|convert_volume|cos|cot|countof|current_cluster_endpoint|current_database|current_principal_details|current_principal_is_member_of|current_principal|cursor_after|cursor_before_or_at|cursor_current|current_cursor|dcount_hll|degrees|dynamic_to_json|estimate_data_size|exp10|exp2|exp|extent_id|extent_tags|extract_all|extract_json|extractjson|extract|floor|format_bytes|format_ipv4_mask|format_ipv4|gamma|gettype|gzip_compress_to_base64_string|gzip_decompress_from_base64_string|has_any_index|has_any_ipv4_prefix|has_any_ipv4|has_ipv4_prefix|has_ipv4|hash_combine|hash_many|hash_md5|hash_sha1|hash_sha256|hash_xxhash64|hash|iff|iif|indexof_regex|indexof|ingestion_time|ipv4_compare|ipv4_is_in_range|ipv4_is_in_any_range|ipv4_is_match|ipv4_is_private|ipv4_netmask_suffix|ipv6_compare|ipv6_is_match|isascii|isempty|isfinite|isinf|isnan|isnotempty|notempty|isnotnull|notnull|isnull|isutf8|jaccard_index|log10|log2|loggamma|log|make_string|max_of|min_of|new_guid|not|bag_pack|pack_all|pack_array|pack_dictionary|pack|parse_command_line|parse_csv|parse_ipv4_mask|parse_ipv4|parse_ipv6_mask|parse_ipv6|parse_path|parse_urlquery|parse_url|parse_user_agent|parse_version|parse_xml|percentile_tdigest|percentile_array_tdigest|percentrank_tdigest|pi|pow|radians|rand|rank_tdigest|regex_quote|repeat|replace_regex|replace_string|reverse|round|set_difference|set_has_element|set_intersect|set_union|sign|sin|split|sqrt|strcat_array|strcat_delim|strcmp|strcat|string_size|strlen|strrep|substring|tan|to_utf8|tobool|todecimal|todouble|toreal|toguid|tohex|toint|tolong|tolower|tostring|toupper|translate|treepath|trim_end|trim_start|trim|unixtime_microseconds_todatetime|unixtime_milliseconds_todatetime|unixtime_nanoseconds_todatetime|unixtime_seconds_todatetime|url_decode|url_encode_component|url_encode|welch_test|zip|zlib_compress_to_base64_string|zlib_decompress_from_base64_string)\b \
        0:function

    # Aggregation functions
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(arg_max|arg_min|avgif|avg|binary_all_and|binary_all_or|binary_all_xor|buildschema|countif|dcount|dcountif|hll|hll_merge|make_bag_if|make_bag|make_list_with_nulls|make_list_if|make_list|make_set_if|make_set|maxif|max|minif|min|percentilesw_array|percentiles_array|percentilesw|percentilew|percentiles|percentile|stdevif|stdevp|stdev|sumif|sum|take_anyif|take_any|tdigest_merge|merge_tdigest|tdigest|varianceif|variancep|variance)\b \
        0:function

    # Window functions
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(next|prev|row_cumsum|row_number|row_rank|row_window_session)\b 0:function

    # Query statements
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(let|set|alias|declare|pattern|query_parameters|restrict|access)\b 0:builtin

    # Function definitions
    add-highlighter shared/kqlsyntax/other/ \
        regex \.(create-or-alter|replace) 0:module

    # Data types
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(bool|decimal|dynamic|guid|int|long|real|string)\b 0:type

    # Join meta keywords
    add-highlighter shared/kqlsyntax/other/ \
        regex \b(on|kind|hint\.remote|hint\.strategy|$left|$right|innerunique|inner|leftouter|rightouter|fullouter|leftanti|anti|leftantisemi|rightanti|rightantisemi|leftsemi|rightsemi|broadcast)\b \
        0:meta

    # String operators
    add-highlighter shared/kqlsyntax/other/ \
        regex (?<!\w)(!?in~?)(?!\w)|(?<!\w)(!?(?:contains|endswith|hasprefix|hassuffix|has|startswith)(?:_cs)?)(?!\w) \
        0:operator
🤔

# When a window's `filetype` option is set to this filetype...
hook global WinSetOption filetype=kql %{
    # Ensure our module is loaded, so our highlighters are available
    require-module kqlsyntax

    # Link our higlighters from the shared namespace
    # into the window scope.
    add-highlighter window/kqlsyntax ref kqlsyntax

    # Add a hook that will unlink our highlighters
    # if the `filetype` option changes again.
    hook -once -always window WinSetOption filetype=.* %{
        remove-highlighter window/kqlsyntax
    }

    set-option window comment_line '//'
}

# Lastly, when a buffer is created for a new or existing file,
# and the filename ends with `.kql`...
hook global BufCreate .+\.kql %{
    # ...we recognise that as our filetype,
    # so set the `filetype` option!
    set-option buffer filetype kql
}
