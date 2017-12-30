shopt -s autocd \
      checkwinsize \
      cmdhist \
      extglob \
      globstar \
      histappend \
      histreedit \
      lithist \
      nocaseglob \
      nocasematch

history -a

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

eval $(dircolors)
for file in \*~ \*.class \*.o \*.fasl; do
    LS_COLORS="$LS_COLORS:$file=38;30;30;2"
done

EDITOR='emacsclient -tc --alternate-editor=vi'

__maybe_window_title() {
    case $TERM in
        xterm*)
            printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
            ;;
        *)
    esac
}

__prompt_command() {
    __maybe_window_title
}

__magit() {
    emacsclient -nq --eval "(magit-status \".\")" &>/dev/null
}

git config --global alias.co checkout
git config --global alias.br branch

declare -A color=(["black"]=$(tput setaf 0) ["red"]=$(tput setaf 1) ["magenta"]=$(tput setaf 5) ["bold"]=$(tput bold) ["reset"]=$(tput sgr0)) &>/dev/null

__source_iff /usr/local/etc/bash_completion.d/git-prompt.sh
__source_iff /usr/local/etc/bash_completion.d/git-completion.bash

__git_ps1=true PS1="\\[${color[bold]}${color[red]}\\]\$(__status=\$?; [ \$__status -ne 0 ] && printf '%d ' \$__status)\\[${color[reset]}${color[bold]}\\]\\h:\\W\\[${color[magenta]}${color[bold]}\\]\$(__git_ps1)\\[${color[reset]}${color[bold]}\\]\\$\\[${color[reset]}\\] "
PROMPT_COMMAND=__prompt_command

if [[ ! "$TERM" =~ (emacs|dumb) ]]; then
    bind "set completion-ignore-case on"
fi

unset color file
