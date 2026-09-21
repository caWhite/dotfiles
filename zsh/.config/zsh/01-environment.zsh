# Keep PATH/FPATH unique, including entries added later by mise and direnv.
typeset -U path PATH fpath FPATH

# PATH: pathmunge is idempotent, so nested shells don't accumulate duplicates.
pathmunge /opt/homebrew/bin
pathmunge "$HOME/.krew/bin"
pathmunge "$HOME/.local/bin"

# FPATH. Must be set before compinit (02-completions.zsh) so these are scanned.
# direnv clobbers FPATH, hence keeping this out of the direnv environment.
fpathmunge "$HOME/.config/zsh/completions"
fpathmunge "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
fpathmunge /opt/homebrew/share/zsh/site-functions

# Non-secret environment. Previously in direnv/.env, which now holds only
# credentials -- keeping those two apart makes the secrets easy to audit.
if command -v nvim > /dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export VISUAL=$EDITOR

export NVM_DIR="$HOME/.nvm"
export COMPOSER_HOME="$HOME/.composer"
export YAMLFIX_CONFIG_PATH="$HOME/yamlfix/"
