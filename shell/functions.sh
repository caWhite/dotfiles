#!/bin/bash

function git-init () {
	for file in $HOME/.dotfiles/github/gitignore/*; do
		if [[ -e $file ]] then
			#ls $file
			cat $file >> "$PWD/.gitignore"
		fi
	done

	git init 
	git add --all 
	git commit -am "Initial commit"
}
