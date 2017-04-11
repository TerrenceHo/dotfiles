#----------------------------Variables--------------------
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/Users/kho/anaconda/bin:$PATH" 
export TERM=screen-256color
export EDITOR=vim
export LSCOLORS="Gxfxcxdxbxegedabagacad"

#----------------------------Editor-----------------------
set -o vi

if (( $+commands[vim] )); then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

#----------------------------Aliases----------------------
alias vi="vim"
alias g="git"
alias tmux='tmux -2'
alias tl='tmux ls'
alias whereami=display_info
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Listing Aliases
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias ds="dirs -v | head -10"

# Directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'
alias pu='pushd'
alias po='popd'

#Grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias t='tail -f'

# Sorts numeric filenames numerically instead of lexicographically
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"

#----------------------------Globbing--------------------
# Makes globs case-insensitive
unsetopt case_glob

# Makes globbing regexes case-insensitive
unsetopt case_match

# Allows globs to match dotfiles
setopt glob_dots

# Sorts numeric filenames numerically instead of lexicographically
setopt numeric_glob_sort

#----------------------------History----------------------
# History file location
export HISTFILE=~/.zsh_history

# Removes the specified commands from the history
export HISTIGNORE="ls:[bf]g:exit:reset:clear:htop"

# Number of lines saved in a session
export HISTSIZE=25000

# Number of lines saved in the history file
export SAVEHIST=10000

# Uses OS-provided locking mechanisms for the history file if available to possibly improve performance and decrease the chance of corruption
setopt hist_fcntl_lock

# Prevents the current line from being saved in the history if it is the same as the previous one
setopt hist_ignore_dups

# Removes superfluous blanks from the history
setopt hist_reduce_blanks

# Expands command instead of immediately executing it when using history expansion
setopt hist_verify

# Incrementally append new history lines to history file rather than waiting until the shell exits
setopt inc_append_history

# Disables sharing history between different zsh sessions
unsetopt share_history

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#------------------------QOL Improvements-----------------
# Uses commas in ls, du, df file size output
export BLOCK_SIZE="'1"

# Colored output on macOS
export CLICOLOR=1

# Prints command execution time if command takes longer than 10 seconds
export REPORTTIME=10

# Background processes aren't killed on exit of shell
setopt auto_continue

# Enter directory path to automatically cd into the directory
setopt autocd

# Makes cd push the old directory onto the directory stack
setopt autopushd

# Doesn't push duplicates onto directory stack
setopt pushd_ignore_dups
 
# Attempts to correct spelling of all arguments in a line
setopt correct_all

# Allows comments in the interactive shell
setopt interactive_comments

# Doesn’t overwrite existing files with '>' but uses '>!' instead
setopt noclobber

# Swaps the meaning of '-' and '+' when used as arguments to cd so '-' means reading from the top of the stack when accessing an entry from the directory stack
setopt pushdminus

# Prompts for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories
setopt rm_star_wait

#----------------------------Tabbing----------------------
autoload -U compinit -u && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';

#----------------------------PROMPT-----------------------
setopt prompt_subst

GIT_THEME_PROMPT_DIRTY='✗'
GIT_THEME_PROMPT_UNPUSHED='+'
GIT_THEME_PROMPT_CLEAN='✓'

function parse_git_dirty() {
   if [[ -n $(git status -s 2> /dev/null |grep -v ^\# | grep -v "working directory clean" ) ]]; then
       echo -ne "%F{160}${GIT_THEME_PROMPT_DIRTY}"
   else
       echo -ne "%F{64}${GIT_THEME_PROMPT_CLEAN}"
   fi
   GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
   GIT_ORIGIN_UNPUSHED=$(git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline 2>&1 | awk '{ print $1 }')
   if [[ $GIT_ORIGIN_UNPUSHED != "" ]]; then
       echo -e "%F{136}${GIT_THEME_PROMPT_UNPUSHED}"
   fi
}

function parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1) $(parse_git_dirty) /"
}

local ret_status="%(?:%B%F{green}➜ %f%b:%B%F{red}➜ %f%b)"
PROMPT='${ret_status} %B%F{125}%n%F{245}@%F{166}%m %F{33}%~ %F{61}$(parse_git_branch)%F{245}$ %f%b'

#-----------------------Cool Function---------------------
function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}

