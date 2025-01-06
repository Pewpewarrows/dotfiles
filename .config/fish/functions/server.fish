# Defined in /var/folders/f9/7rlz_f1s2kn9rrf20h2bgg0r0000gn/T//fish.69EjTr/server.fish @ line 1
function server --argument port
    if test -z "$port"
        set port "8000"
    end

    if test -z "$SSH_TTY"
        # fish does not yet natively support backgrounding of blocks of code,
        # so fake it by re-shelling out
        fish --command "sleep 0.25; and open 'http://localhost:$port'" &
    end

    command python -m (python -c 'import sys; print("http.server" if sys.version_info[:2] >= (3,0) else "SimpleHTTPServer")') $port
end
