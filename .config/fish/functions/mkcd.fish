function mkcd
    # TODO: zsh calls this `take` instead
	mkdir -pv $argv
    cd $argv
end
