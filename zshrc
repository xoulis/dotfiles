# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
#customizations
#
#fzf
source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/fzf-extras.zsh && source /usr/share/zsh/plugins/fzf-tab-bin-git/fzf-tab.plugin.zsh

##fetch app
neofetch
## zathura to preview pdf
#complete -o bashdefault -o defult -F _fzf-path_completion zathura
