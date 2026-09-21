# (N) so an empty/missing config dir is not a startup error.
for config in ~/.config/zsh/*.zsh(N); do
  source "$config"
done

autoload -U select-word-style
select-word-style bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
