# Only attach to tmux for a real interactive terminal -- tools that spawn
# `zsh -i -c ...` (editors, agents, scripts) must not get dropped into tmux.
if [[ -o interactive && -t 1 && -z "$TMUX" ]] && command -v tmux > /dev/null 2>&1; then
  tmux new-session -A -s workspace
fi

if command -v mise > /dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if command -v starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# nvm, lazy-loaded. Sourcing nvm.sh eagerly cost ~2.6s on every shell start,
# ~85% of total startup. mise owns node/npm (it pins node and reads .nvmrc),
# so nvm is only needed for the occasional explicit `nvm use` -- pay on first
# call instead. NVM_DIR is set in 01-environment.zsh; it previously came from
# direnv, whose hook has not run yet here, so this block did nothing at all.
if [ -s "$NVM_DIR/nvm.sh" ]; then
  nvm() {
    unfunction nvm
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
  }
fi

bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word
