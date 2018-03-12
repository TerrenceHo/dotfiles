#-------------Environment Variables----------------
export PATH="$PATH:/usr/local/bin" 
export PATH="/Users/kho/anaconda/bin:$PATH" # Anaconda/Python
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH" # Postgres

# Golang environment Settings
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin # setting my GOPATH
export GOPATH=$(go env GOPATH) # easier way of saying GOPATH
export GOROOT=/usr/local/go


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kho/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kho/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/kho/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kho/google-cloud-sdk/completion.zsh.inc'; fi

# shell export settings
export TERM=screen-256color
export EDITOR=vim
export LSCOLORS="Gxfxcxdxbxegedabagacad"

set -o vi
if (($+commands[vim] )); then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

export SPOTIFY_CLIENT_ID="3a0151c1b0734cd587a51918251ff40d"
export SPOTIFY_CLIENT_SECRET="458e249b0e4648559479038067eb8f26"
