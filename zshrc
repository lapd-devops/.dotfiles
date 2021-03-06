# History
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000

# PATHS
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.krew/bin
export MANPATH=$MANPATH:/usr/local/man
export LANG=en_US.UTF-8

## GOLANG
if [ -d "$GOPATH" ]; then
  export PATH="$GOPATH/bin:$PATH"
elif [[ $commands[go] ]]; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

# EDITOR
export VISUAL='vi'

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="$VISUAL"
else
  export EDITOR="$VISUAL"
fi

# ALIAS
alias vi='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ZINIT
# REF. https://github.com/zdharma/zinit
## Check if zinit is installed
if [[ ! -d ~/.zinit ]]; then
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit self-update

# ZINIT: Plugins
zinit light zsh-users/zsh-autosuggestions
#zinit light zsh-users/zsh-completions
#zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/fast-syntax-highlighting
zinit load zdharma/history-search-multi-word

zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# ZINIT: Snippets
# Oh-my-zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/tig/tig.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit snippet OMZ::plugins/helm/helm.plugin.zsh
zinit snippet OMZ::plugins/docker/_docker
zinit snippet OMZ::plugins/minikube/minikube.plugin.zsh
zinit snippet OMZ::plugins/terraform/terraform.plugin.zsh
zinit snippet OMZ::plugins/asdf/asdf.plugin.zsh

# Zstyle!
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U promptinit && promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT="%F{113}%m%F{227}の%F{197}%n %{$reset_color%}❯ "
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# AUTOCOMPLETE
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
complete -C "$HOME/bin/aws_completer" aws
source /etc/bash_completion.d/azure-cli
source /etc/bash_completion.d/gcloud
source <(helm completion zsh)
source $HOME/.asdf/asdf.sh && source $HOME/.asdf/completions/asdf.bash
