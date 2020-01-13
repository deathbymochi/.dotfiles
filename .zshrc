#
# User configuration sourced by interactive shells
#
# -----------------
# Zsh configuration
# -----------------
#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# old config:
DISABLE_CORRECTION="true"

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"


#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
# zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions (install via homebrew)
#
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

# Bind keys for autosuggestions
# ctrl + space
bindkey '^ ' autosuggest-accept

#
# zsh-syntax-highlighting (install via homebrew)
#
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=10'

#
# zsh-history-substring-search (install with homebrew)
#
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#
# zsh-completions
#
fpath=(/usr/local/share/zsh-completions $fpath)

# ------------------
# Initialize modules
# ------------------

#
# zim
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

#
# virtualenvwrapper
#

# # Setup virtualenvwrapper to work correctly
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/PythonDevel
# source /usr/local/bin/virtualenvwrapper.sh

#
# Aliases - use ~/.aliases file
#

source ${HOME}/.aliases


# We need this so that tmux uses zsh when started in a zsh shell
export SHELL='/bin/zsh'

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search (vi mode)
#

bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
bindkey -M vicmd '^k' history-substring-search-up
bindkey -M vicmd '^j' history-substring-search-down

#
# zsh-edit-command-line (vi mode)
#

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

# ------------------------------
# Completions for other CL tools
# ------------------------------

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/tiffanyhu/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tiffanyhu/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/tiffanyhu/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tiffanyhu/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# # The next line enables shell command completion for kubectl (kubernetes)
# if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

# # asdf config
# . $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash
