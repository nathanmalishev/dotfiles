# Path to your oh-my-zsh installation.
export ZSH=/Users/nathan/.oh-my-zsh

# 10ms for key sequences
KEYTIMEOUT=1


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="geoffgarside"
# PROMPT="[%*] %n:%c $(git_prompt_info)%(!.#.$) "

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
#ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

# User configuration
export ANDROID_HOME="/Users/nathan/Library/Android/sdk"

export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/platforms/"/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/usr/local/terraform:/usr/local/gnat/bin:$HOME/coding/flutter/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="/Users/nathan/.nvm"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"


# set -o vi
set -o vi
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


export PATH="$HOME/.yarn/bin:$PATH:~/java/apache-maven-3.5.0/bin:$HOME/nathanBin"
export GOPATH=$HOME/go
export PATH=$PATH:~/go/bin
# sam cli
export PATH=$PATH:/Users/nathan/Library/Python/2.7/bin/

. ~/Apps/z/z.sh

alias nv='nvim'
alias when='ntfy'
alias ls='exa'
# exa:
alias la="exa -abghl --git --color=automatic"
alias ca='pygmentize -f terminal256 -O style=native -g'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/nathan/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh

# added by travis gem
[ -f /Users/nathan/.travis/travis.sh ] && source /Users/nathan/.travis/travis.sh
