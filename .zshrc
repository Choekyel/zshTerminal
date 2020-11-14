# Shell prompt based on the Solarized Dark theme.
# Text -> use 13pt Monaco with 1 spacing.
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;

# Git in Zsh (tab-completion, version control systems and branch name)
autoload -Uz compinit && compinit -u
autoload -U colors && colors
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    newline=$'\n';
    # Solarized colors
    black=$(tput setaf 0);
    blue=$(tput setaf 153);
    green=$(tput setaf 71);
    orange=$(tput setaf 166);
    red=$(tput setaf 167);
    white=$(tput setaf 15);
    yellow=$(tput setaf 222);
    lightblue=$(tput setaf 81);
else
    bold='';
    reset="\e[0m";
    black="\e[1;30m";
    blue="\e[1;34m";
    green="\e[1;32m";
    orange="\e[1;33m";
    red="\e[1;31m";
    white="\e[1;37m";
    yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    userStyle="${red}";
else
    userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}";
else
    hostStyle="${yellow}";
fi;

# Git in Zsh (tab-completion, version control systems and branch name)
autoload -Uz compinit && compinit -u
autoload -U colors && colors
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt PROMPT_SUBST
RPROMPT=\$vcs_info_msg_0_


# Set the terminal title and prompt to the current working directory.
PS1="${bold}${newline}";
PS1+="${userStyle}%n"; # username
PS1+="${white} at ";
PS1+="${hostStyle}%m"; # hostname up to the first '.'
PS1+="${white} using ";
PS1+="${lightblue}%N"; # name of the script, sourced file or shell function that zsh is executing
PS1+="${white} in ";
PS1+="${green}%1~"; # current working directory (Showing only one directory)
PS1+= zstyle ':vcs_info:git:*' formats "%{$fg[cyan]%}-%s%{$reset_color%} on %{$fg[magenta]%}%b %{$fg[yellow]%}%a%{$fg[red]%}%u%{$fg[green]%}%c%{$fg[blue]%}%m%{$reset_color%}"; # Git repository details
PS1+="${newline}";
PS1+="${white}$ ${reset}"; # reset color
export PS1;

PS2="${yellow}-> ${reset}"; # '$' (and reset color)
export PS2;
