export TERM='xterm-256color'

POWERLEVEL9K_MODE='awesome-patched'

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda vcs dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# To make mactex available in PATH
eval `/usr/libexec/path_helper -s`

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# cmake and cmake-gui
PATH=/Applications/CMake.app/Contents/bin:$PATH

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
PATH=$JAVA_HOME/bin:$PATH

# PATH=/Users/oscarvarto/Library/Python/3.7/bin:$PATH
. /usr/local/anaconda3/etc/profile.d/conda.sh

# haskell
PATH=~/.local/bin:~/.cabal/bin:$PATH

# dotnet
PATH=~/fake-dotnetcore:$PATH
PATH=/usr/local/share/dotnet:$PATH

# rust
PATH="$HOME/.cargo/bin:$PATH"

export PATH

export GOOGLE_APPLICATION_CREDENTIALS=/Users/oscarvarto/Downloads/DataEngDemo-a624d3c30fe9.json

alias blog='make devserver'
alias blog-stop='./develop_server.sh stop'
alias blog-update='ghp-import -b master output'

alias gpush='git push origin master'

#alias sp='HOME=~/spacemacs emacs --daemon=instance1'
alias sp='emacs --daemon=instance1'

#alias et='HOME=~/spacemacs emacsclient -qc -nw -s instance1'
alias et='emacsclient -qc -nw -s instance1'

#alias em='HOME=~/spacemacs emacsclient -nqc -s instance1'
alias em='emacsclient -nqc -s instance1'

alias ppath='echo -e ${PATH//:/\\n}'
