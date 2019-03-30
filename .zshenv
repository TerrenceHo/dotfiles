#-------------Environment Variables----------------

if [[ -z $TMUX ]]; then
    export PATH=$PATH:~/.local/bin
    # export PATH=$PATH:~/anaconda/bin # Anaconda/Python

    # Golang environment Settings
    export PATH=$PATH:$(go env GOPATH)/bin # setting my GOPATH
    export GOPATH=$(go env GOPATH) # easier way of saying GOPATH
    export GOROOT=/usr/local/go


    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/kho/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kho/google-cloud-sdk/path.zsh.inc'; fi
    # The next line enables shell command completion for gcloud.
    if [ -f '/Users/kho/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kho/google-cloud-sdk/completion.zsh.inc'; fi

    # opam configuration
    test -r /Users/kho/.opam/opam-init/init.zsh && . /Users/kho/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

    # racket
    export PATH=$PATH:"/Applications/Racket v7.1/bin"

    # RUBY
    eval "$(rbenv init -)"
fi

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

. /Users/kho/anaconda/etc/profile.d/conda.sh
