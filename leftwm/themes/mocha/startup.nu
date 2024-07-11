$env.config.color_config = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: cyan_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    # eg) {|| if $in { 'light_green' } else { 'light_gray' } }
    bool: light_green
    int: white
    filesize: green
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: cyan_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: {bg: red fg: white}
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_green
    shape_closure: cyan_bold
    shape_custom: cyan
    shape_datetime: green_bold
    shape_directory: green
    shape_external: light_grey
    shape_externalarg: cyan_bold
    shape_external_resolved: green_bold
    shape_filepath: green
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_globpattern: green_bold
    shape_int: purple_bold
    shape_internalcall: green_bold
    shape_keyword: green_bold
    shape_list: green_bold
    shape_literal: blue
    shape_match_pattern: cyan
    shape_matching_brackets: { attr: u }
    shape_nothing: light_green
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: green_bold
    shape_redirection: purple_bold
    shape_signature: cyan_bold
    shape_string: cyan
    shape_string_interpolation: green_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
}

def create_left_prompt [] {
    let home =  $nu.home-path

    # Perform tilde substitution on dir
    # To determine if the prefix of the path matches the home dir, we split the current path into
    # segments, and compare those with the segments of the home dir. In cases where the current dir
    # is a parent of the home dir (e.g. `/home`, homedir is `/home/user`), this comparison will
    # also evaluate to true. Inside the condition, we attempt to str replace `$home` with `~`.
    # Inside the condition, either:
    # 1. The home prefix will be replaced
    # 2. The current dir is a parent of the home dir, so it will be uneffected by the str replace
    let dir = (
        if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $home "~")
        } else {
            $env.PWD
        }
    )

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi black_bold})
    let path_segment = $"(ansi white_bold)[(ansi reset)($path_color)($dir)(ansi reset)(ansi white_bold)] "

    $path_segment | str replace --all (char path_sep) $"(ansi reset)($separator_color)(char path_sep)(ansi reset)($path_color)"
}
$env.PROMPT_COMMAND = {|| create_left_prompt}

alias gitui = gitui -t zelda.ron

# with-env {
# SHELL: /usr/bin/nu,
# FONT: (wezterm ls-fonts | split row "\n" | get 4 | split chars | drop 2 | skip 3 | str join ""),
# LEFTWM_THEME: (uu-realpath ~/.config/leftwm/themes/current/ | path parse | get stem | split chars | str join)
# } {neofetch}
