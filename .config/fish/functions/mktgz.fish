# Defined in /var/folders/f9/7rlz_f1s2kn9rrf20h2bgg0r0000gn/T//fish.NXYFku/mktgz.fish @ line 1
function mktgz --argument name
    set name (string replace --regex '/$' '' $name)
    command tar cvzf "$name.tar.gz" "$name/"
end
