# Defined in /var/folders/f9/7rlz_f1s2kn9rrf20h2bgg0r0000gn/T//fish.69EjTr/server.fish @ line 1
function server --argument port
    if test -z "$port"
        set port "8000"
    end

    if test -z "$SSH_TTY"
        command open "http://localhost:$port" &
    end

    command python -m SimpleHTTPServer $port
end
