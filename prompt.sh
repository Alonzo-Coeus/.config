sps() {
	echo ${PWD/#$HOME/\~} | sed "s:\(\.\?[^/]\)[^/]*/:\1/:g"
}

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

git_colour() {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}					   

function ret_colour {
  RETVAL=$?
  if [ $RETVAL -ne 0 ]; then
    echo -e "\033[0;31m"
  else
    echo -e "\033[0;32m"
  fi
}

export PS1='\[\033[1;32m\]<\t> \u@\h:$(eval "sps")\[$(git_colour)\]$(git_branch)\[$(ret_colour)\] λ\[\033[0m\] '
export PS2="| "
