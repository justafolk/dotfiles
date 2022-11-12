# Nord Theme settings
set -g fish_color_normal normal
set -g fish_color_command 81a1c1
set -g fish_color_quote a3be8c
set -g fish_color_redirection b48ead
set -g fish_color_end 88c0d0
set -g fish_color_error ebcb8b
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_history_current --bold
set -g fish_color_operator 00a6b2
set -g fish_color_escape 00a6b2
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_valid_path --underline
set -g fish_color_autosuggestion 4c566a
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel -r
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_color_param eceff4
set -g fish_color_comment 434c5e
set -g fish_color_match --background=brblue

function fish_prompt --description 'Write t the prompt'
    set -l last_pipestatus $pipestatus
    # Export for __fish_print_pipestatus.
    set -lx __fish_last_status $status
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        set suffix '#'
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Write pipestatus
    # If the status was carried over (e.g. after `set`), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l prompt_status (\
        __fish_print_pipestatus "[" "]" "|" (set_color -i $fish_color_status) \
        (set_color -i $bold_flag $fish_color_status) $last_pipestatus\
    )

    # Calculate command duration time with two decimal places
    # Examples: 1h, 1.87m, 10.42s, 141ms
    set -l d $CMD_DURATION
    set -l second 1000
    set -l minute (math 60 \* $second)
    set -l hour (math $minute \* 60)
    set -l s (math -s0 $d / $second)
    set -l m (math -s0 $d / $minute)
    set -l h (math -s0 $d / $hour)
    set -l duration

    if test $h -gt 0
        set h (math -s2 $d / $hour)
        set duration $h'h'
    else if test $m -gt 0
        set m (math -s2 $d / $minute)
        set duration $m'm'
    else if test $s -gt 0
        set s (math -s2 $d / $second)
        set duration $s's'
    else
        set duration $d'ms'
    end

    echo -n -s \
        (set_color $fish_color_user) "$USER" \
        $normal @ \
        (set_color $color_host) (prompt_hostname) \
        $normal ' ' (set_color $color_cwd) (prompt_pwd) \
        $normal (set_color -i)(fish_vcs_prompt) \
        ' '$prompt_status ' '(set_color -id white)"$duration$normal " $suffix' '
end
