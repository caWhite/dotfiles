# Cache generated completions instead of running `<tool> completion zsh` in a
# subshell on every startup. Each cache file is regenerated when the tool
# binary is newer than it, so upgrades pick themselves up.
_zcompcache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions
mkdir -p "$_zcompcache"

for _tool in kubectl flux flux-operator; do
  _bin=$(command -v "$_tool") || continue
  _out=$_zcompcache/_$_tool
  if [[ ! -s $_out || $_bin -nt $_out ]]; then
    "$_tool" completion zsh > "$_out" 2>/dev/null || rm -f "$_out"
  fi
done
unset _tool _bin _out

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename "$HOME/.config/zsh/02-completions.zsh"

# Rebuild the dump at most once a day; use the fast path otherwise.
autoload -Uz compinit
_zcompdump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
mkdir -p "${_zcompdump:h}"
if [[ -n ${_zcompdump}(#qN.mh+24) ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompcache _zcompdump

# aws ships a bash-style completer, which needs bashcompinit (after compinit).
if command -v aws_completer > /dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C "$(command -v aws_completer)" aws
fi
