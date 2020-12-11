
#
# User configuration sourced by login shells
#

# TODO: these are correctly sourced via .zlogin but not via .zshenv; look into this, maybe some ordering of config happening
source ${HOME}/.env

# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh
