# Defined in /var/folders/f9/7rlz_f1s2kn9rrf20h2bgg0r0000gn/T//fish.gBp82J/__fish_list_current_token.fish @ line 2
function __fish_list_current_token --description 'List contents of token under the cursor if it is a directory, otherwise list the contents of the current directory'
    set val (eval echo (commandline -t))
    printf "\n"
    if test -d $val
        exa $val
    else
        set dir (dirname -- $val)
        if test $dir != . -a -d $dir
            exa $dir
        else
            exa
        end
    end

    set -l line_count (count (fish_prompt))
    if test $line_count -gt 1
        for x in (seq 2 $line_count)
            printf "\n"
        end
    end

    commandline -f repaint
end
