autoload -Uz colors && colors
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# precmd() { vcs_info }
PROMPT="%{$fg_bold[red]%}@%m %{$fg_bold[green]%}%D{%Y/%m/%d %H:%M} %{$fg_bold[cyan]%}%c %{$fg_bold[blue]%}
%% %{$reset_color%}"
