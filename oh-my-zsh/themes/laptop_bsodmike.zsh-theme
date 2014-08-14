rvm_current() {
  rvm current 2>/dev/null
}

rbenv_version() {
  rbenv version 2>/dev/null | awk '{print $1}'
}

battery_charge() {
  if [ -e ~/code/dotfiles/oh-my-zsh/battery.py ]
  then
    echo `python ~/code/dotfiles/oh-my-zsh/battery.py`
  else
    echo ''
  fi
}

prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    local output="${ref/refs\/heads\//⭠ }$dirty"
    if [[ -n $dirty ]]; then
      echo -n "$fg[red]$output"
    else
      echo -n "$fg[green]$output"
    fi
  fi
}

# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local time_stamp='%{$fg[blue]%}%D{[%H:%M:%S]} %{$reset_color%}%'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local rvm_ruby='%{$fg[green]%}{$(rbenv_version)}%{$reset_color%}'
local git_branch='$(prompt_git)%{$reset_color%}'

PROMPT="${user_host} ${time_stamp} %2c ${rvm_ruby} ${git_branch}
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#RPROMPT='%{$reset_color%}$(battery_charge)%{$reset_color%}'

