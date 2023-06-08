# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Greeting

# Prompt
PROMPT="%F{red}â”Œ[%f%F{cyan}%m%f%F{red}]â”€[%f%F{yellow}%D{%H:%M-%d/%m}%f%F{red}]â”€[%f%F{magenta}%d%f%F{red}]%f"$'\n'"%F{red}â””â•¼%f%F{green}$USER%f%F{yellow}$%f"
# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/opt/go/bin/:/opt/kerbrute/:/opt/ghidra/:/opt/nvim-linux64/bin/:/opt/:/opt/exploitdb/:/CrackMapExec/:/opt/Girsh/src/:/root/depot_tools:/CrackMapExec/crackmapexec-DkKVfGHZ-py3.9/bin/:/opt/kerbrute/dist/:/opt/enum4linux/:$PATH 
export ORACLE_HOME=/usr/lib/oracle/21/client64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
export PATH=$PATH:${ORACLE_HOME}bin
export POETRY_VIRTUALENVS_PATH=/CrackMapExec/
export EDITOR=/opt/nvim-linux64/bin/nvim
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

function hex-encode()
{
  echo "$@" | xxd -p
}

function hex-decode()
{
  echo "$@" | xxd -p -r
}

function rot13()
{
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# alias
alias ls='ls -lh --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#####################################################
# Auto completion / suggestion
# Mixing zsh-autocomplete and zsh-autosuggestions
# Requires: zsh-autocomplete (custom packaging by Parrot Team)
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command history
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-sudo/sudo.plugin.zsh
[[ -s /home/sexcott/.autojump/etc/profile.d/autojump.sh ]] && source /home/sexcott/.autojump/etc/profile.d/autojump.sh
#source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history
bindkey '^k' kill-line
bindkey -e


##################################################
# Fish like syntax highlighting
# Requires "zsh-syntax-highlighting" from apt

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-sudo/sudo.plugin.zsh

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Save type history for completion and easier life
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
# setopt appendhistory
setopt histignorealldups sharehistory

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"
# Display last command interminal
echo -en "\e]2;Parrot Terminal\a"
preexec () { print -Pn "\e]0;$1 - Parrot Terminal\a" }

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom Aliases
alias cat='/bin/bat'
alias catn='/bin/cat'
alias catnl='/bin/bat --paging=never'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias vim='/opt/nvim-linux64/bin/nvim'
alias icat='kitty +kitten icat'
alias git-dumper='python3 /opt/git-dumper/git_dumper.py'
alias gopherus='python2 /opt/Gopherus/gopherus.py'


# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '^Host: .* \(\)' | head -n 1 | awk '{print $2}')"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

function persistences(){
   cat /opt/persistences/persistences -l powershell
}

# MKT function
function mkt(){
	mkdir {nmap,content,exploits}
}

function settarget(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > /home/sexcott/.config/bin/target
}

function turnUpBright(){
	bright=$1
	echo "$bright" > /sys/class/backlight/amdgpu_bl0/brightness
}

function showBattery(){
	echo 'El porcentaje de la bateria es:' $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | awk 'NF{print $NF}')
}

function clearDocker(){
  docker rm $(docker ps -a -q) --force 2>/dev/null
  docker rmi $(docker images -q) --force 2>/dev/null
  docker network rm $(docker network ls -q) 2>/dev/null
  docker volume rm $(docker volume ls -q) 2>/dev/null
}

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^R" history-incremental-search-backward

# VI Mode
# bindkey -v

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'



# Created by `pipx` on 2023-01-09 15:25:11
export PATH="$PATH:/root/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
