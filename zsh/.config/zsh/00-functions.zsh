# Prepend (or append, with "after") to PATH/FPATH only if not already present.
# Defined first so 01-environment.zsh can use them.
pathmunge () {
    case ":${PATH}:" in
        *:"$1":*) ;;
        *)
            if [ "$2" = "after" ]; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

fpathmunge () {
    case ":${FPATH}:" in
        *:"$1":*) ;;
        *)
            if [ "$2" = "after" ]; then
                FPATH=$FPATH:$1
            else
                FPATH=$1:$FPATH
            fi
    esac
}

gcloud-cd-project () {
  gcloud config set project "$1"
  gcloud auth application-default set-quota-project "$1"
}

totp () {
  ykman oath accounts code "${TOTP_ACCOUNT:-ZMG-USR}" -s | pbcopy
}

# Seed a new repo with the gitignore templates in ~/.dotfiles/github/gitignore.
git-init () {
  local templates=$HOME/.dotfiles/github/gitignore
  if [ -e .gitignore ]; then
    echo "git-init: .gitignore already exists, refusing to overwrite" >&2
    return 1
  fi
  cat "$templates"/*.gitignore > .gitignore
  git init && git add --all && git commit -m "Initial commit"
}
