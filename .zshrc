#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
# User configuration sourced by interactive shells
#

# Aliases - use ~/.aliases file
source ${HOME}/.aliases

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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

DISABLE_CORRECTION="true"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# We need this so that tmux uses zsh when started in a zsh shell
export SHELL='/bin/zsh'

# Use vi mode
bindkey -v

# Vi mode settings

bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
bindkey -M vicmd '^k' history-substring-search-up
bindkey -M vicmd '^j' history-substring-search-down

# Still have delete key delete char
bindkey -M vicmd '^[[3~' delete-char

autoload -Uz edit-command-line
zle -N edit-command-line
# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Show which edit mode we're in
function zle-line-init zle-keymap-select {
    NORMAL="%F{11}[% NORMAL]%  %{$reset_color%}"
    INSERT="%F{13}[% INSERT]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
