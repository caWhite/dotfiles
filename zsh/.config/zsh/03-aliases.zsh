alias ..='cd ..'
alias grep='grep --color=auto'

alias k='kubectl'
alias ks='kustomize'
alias kb='kustomize build --load-restrictor LoadRestrictionsNone'
alias kns='kubens'
alias ktx='kubectx'

alias l='ls -ACF'
alias la='ls -A'
alias ll='ls -AlF'
alias ls='ls --color=auto'
alias tf='terraform'

alias n=nvim
alias vi=nvim
alias vim='nvim'

# macOS clipboard. xclip is X11-only and needs XQuartz running.
alias c='pbcopy'
alias v='pbpaste'
alias cs='pbcopy'
alias vs='pbpaste'

# Sourced after compinit (02-completions.zsh), which is what defines compdef.
compdef k=kubectl
compdef ktx=kubectx
compdef kns=kubens
# terraform ships a bash-style completer rather than a zsh one.
if command -v terraform > /dev/null 2>&1; then
  complete -o nospace -C "$(command -v terraform)" terraform tf
fi
