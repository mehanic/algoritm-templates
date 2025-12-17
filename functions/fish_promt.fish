function fish_prompt
    # Cache exit status
    set -l last_status $status

    # Just calculate once
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (uname -n | cut -d . -f 1)
    end
    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set -g __fish_prompt_char '#'
            case '*'
                set -g __fish_prompt_char 'λ'
        end
    end

    # Colors
    set -l hostcolor (set_color (uname -n | md5sum | cut -f1 -d' ' | tr -d '\n' | tail -c6))
    set -l normal (set_color normal)
    set -l white (set_color FFFFFF)
    set -l turquoise (set_color 5fdfff)
    set -l orange (set_color df5f00)
    set -l hotpink (set_color df005f)
    set -l blue (set_color blue)
    set -l limegreen (set_color 87ff00)
    set -l purple (set_color af5fff)
    set -l red (set_color ff0000)
    set -l green (set_color 00ff00)

    # Git prompt config
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color 5fdfff
    set -g __fish_git_prompt_color_flags df5f00
    set -g __fish_git_prompt_color_prefix white
    set -g __fish_git_prompt_color_suffix white
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_show_informative_status true

    set -l current_user (whoami)

    ##
    ## Line 1: Main prompt
    ##
    echo -n $hostcolor'╭─'$hotpink$current_user$white' at '$orange$__fish_prompt_hostname$white' in '$limegreen(pwd | sed "s=$HOME=⌁=")$turquoise
    __fish_git_prompt " (%s)"

    # Kubernetes context / namespace
    set -l kube_context (kubectl config current-context ^/dev/null 2>/dev/null)
    set -l kube_ns (kubectl config view --minify --output 'jsonpath={..namespace}' ^/dev/null 2>/dev/null)
    if test -n "$kube_context"
        if test -z "$kube_ns"
            set kube_ns "default"
        end

        # Колір namespace
        if test "$kube_ns" = "default"
            set -l ns_color $red
        else
            set -l ns_color $green
        end

        echo -n $purple' ['$kube_context':'$ns_color$kube_ns$purple']'
    end
    echo

    ##
    ## Line 2: Secondary prompt line
    ##
    echo -n $hostcolor'╰'

    # Disable virtualenv's default prompt
    set -g VIRTUAL_ENV_DISABLE_PROMPT true

    # Show virtualenv name if present
    if set -q VIRTUAL_ENV
        echo -n "($turquoise"(basename "$VIRTUAL_ENV")"$white)"
    end

    # Support for vi mode
    set -l lambdaViMode "$THEME_LAMBDA_VI_MODE"
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        if test -z (string match -ri '^no|false|0$' $lambdaViMode)
            set_color --bold
            echo -n $white'─['
            switch $fish_bind_mode
                case default
                    set_color red
                    echo -n 'n'
                case insert
                    set_color green
                    echo -n 'i'
                case replace_one
                    set_color green
                    echo -n 'r'
                case replace
                    set_color cyan
                    echo -n 'r'
                case visual
                    set_color magenta
                    echo -n 'v'
            end
            echo -n $white']'
        end
    end

    # Rest of prompt
    echo -n $hostcolor'─'$white$__fish_prompt_char $normal
end

