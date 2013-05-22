# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local time_stamp='%{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local rvm_ruby='%{$fg[green]%}{$(rbenv version-name)}%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="${user_host} ${time_stamp} %2c ${rvm_ruby} ${git_branch}
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
