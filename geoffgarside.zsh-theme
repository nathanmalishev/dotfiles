# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY="%{$RED%}*%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"


### above all from juanghurtado

# PROMPT="[%*] %n:%c $(git_prompt_info)%(!.#.$) "
PROMPT='[%*] %{$fg[cyan]%}%n%{$reset_color%}:%{$fg[green]%}%c%{$reset_color%}$(git_prompt_info) %(!.#.)%{$GREEN_BOLD%}$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}
%{$GREEN_BOLD%}:: > %{$WHITE%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
