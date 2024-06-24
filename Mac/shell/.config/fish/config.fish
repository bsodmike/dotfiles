ulimit -u 10000
ulimit -n 2048

set -x EDITOR /opt/homebrew/bin/nvim

set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH /usr/local/bin/
set -x PATH $PATH /opt/homebrew/bin/

#set -x LIBCLANG_PATH $HOME/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-aarch64-apple-darwin/lib/
#fish_add_path $HOME/.espressif/tools/xtensa-esp32-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/
#fish_add_path $HOME/.espressif/tools/xtensa-esp32s2-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/
#fish_add_path $HOME/.espressif/tools/xtensa-esp32s3-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/

set -x PORTENTA_X8_IP dig +short portenta-x8-01.intranet
set -x PFSENSE_IP dig +short pfsense.intranet

abbr -a lt 'tree . -L 2'
abbr -a vim 'nvim'
abbr -a gri 'git rebase -i --autosquash'
abbr -a gfix 'git commit --fixup'
abbr -a gundo 'git reset HEAD~'
abbr -a gnow 'git commit --amend --date=now --no-edit'
abbr -a tmux-clean 'tmux ls | awk \'BEGIN{FS=":"}!/attached/{print $1}\' | xargs -n 1 tmux kill-ses -t'
abbr -a pfsense.intranet 'ssh ({$PFSENSE_IP})'
abbr -a portenta-x8-01.intranet 'ssh mike@({$PORTENTA_X8_IP})'
abbr -a my_ip  'ifconfig | grep -C 5 en0 | grep \'inet 10.1\' | awk \'{print $6}\''

# Other aliases
abbr -a yr 'cal -y'
abbr -a c cargo
abbr -a e nvim
abbr -a m make
abbr -a o xdg-open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'
abbr -a amz 'env AWS_SECRET_ACCESS_KEY=(pass www/aws-secret-key | head -n1)'
abbr -a ais "aws ec2 describe-instances | jq '.Reservations[] | .Instances[] | {iid: .InstanceId, type: .InstanceType, key:.KeyName, state:.State.Name, host:.PublicDnsName}'"
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a ks 'keybase chat send'
abbr -a kr 'keybase chat read'
abbr -a kl 'keybase chat list'
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'

if status --is-interactive
	if test -d ~/dev/others/base16/templates/fish-shell
		set fish_function_path $fish_function_path ~/dev/others/base16/templates/fish-shell/functions
		builtin source ~/dev/others/base16/templates/fish-shell/conf.d/base16.fish
	end
	#tmux 2> /dev/null; and exec true
end


if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

function ssh
	switch $argv[1]
	case "*.amazonaws.com"
		env TERM=xterm /usr/bin/ssh $argv
	case "ubuntu@"
		env TERM=xterm /usr/bin/ssh $argv
	case "*"
		/usr/bin/ssh $argv
	end
end


function qrsend
	if test (count $argv) -ne 1
		echo "No argument given"
		return
	end

	qrencode -o - $argv[1] | feh --geometry 500x500 --auto-zoom -
end

function limit
	numactl -C 0,1,2 $argv
end


# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'


# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (hostname)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color yellow
		echo -n (basename $PWD)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '| '
	set_color normal
end


eval (/opt/homebrew/bin/brew shellenv)
~/load_ssh_keys.sh

status --is-interactive; and rbenv init - fish | source
status --is-interactive; and atuin init fish | source

if status is-interactive
    eval (zellij setup --generate-completion fish | string collect)
end

