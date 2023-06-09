autoload -U compinit && compinit

#PATH=$PATH:/usr/local/bin

if [ -f /mnt/.devcontainer/shell-history ]; then
    HISTFILE=/mnt/.devcontainer/shell-history
fi

HISTSIZE=10000
SAVEHIST=10000
setopt share_history

alias kc='kubectl'
alias l='ls --color -lha --group-directories-first'

source <(kubectl completion zsh )
source <(helm completion zsh)
#complete -F __start_kubectl k

# make autocompletion
# https://unix.stackexchange.com/a/499322/3098

zstyle ':completion:*:*:make:*' tag-order 'targets'

plugins=(kubectl zsh-syntax-highlighting zsh-autosuggestions)

# https://stackoverflow.com/a/65045491
_git_branch() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    echo "%F{yellow}[%f%F{red}${ref}%f%F{yellow}]%f"
  else
    echo ""
  fi
}
setopt PROMPT_SUBST
PS1='%F{green}%M%f:%F{cyan}%~$(_git_branch)$ '

if test -f "~/.kube/config"; then
  echo "Found existing cluster configuration..."
fi
