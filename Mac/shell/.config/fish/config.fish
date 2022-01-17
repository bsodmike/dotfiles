set PATH $HOME/.cargo/bin $PATH

abbr -a vim 'nvim'
abbr -a gri 'git rebase -i --autosquash'
abbr -a gfix 'git commit --fixup'
abbr -a gundo 'git reset HEAD~'

if status is-interactive
    # Commands to run in interactive sessions can go here
end
