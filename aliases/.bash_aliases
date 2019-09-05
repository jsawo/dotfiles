# =====================================
# general
#
alias ..='cd ..'
alias cd..='cd ..'

# =====================================
# ls
#
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# list files
alias lf="ll -p | grep -v /"
# list directories
alias ld="ll -p | grep /"

# =====================================
# artisan
#
alias pa='php artisan'

# =====================================
# phpunit
#
#alias pu='phpunit --testdox'
#alias puf='phpunit --testdox --filter'
#alias pui='phpunit --group integration --testdox'
#alias puif='phpunit --group integration --testdox --filter'
alias pu='./vendor/bin/phpunit'
alias puf='./vendor/bin/phpunit --filter'
alias pui='./vendor/bin/phpunit --group integration'
alias puif='./vendor/bin/phpunit --group integration --filter'

# =====================================
# npm
#
alias nr='npm run'
alias npr='npm run'
alias npl='npm list --depth=0'
alias nplg='npm list -g --depth=0'
alias npu='npm-check -u'
alias npug='npm-check -gu'
alias npa='npm audit'
alias npaf='npm audit fix'

# =====================================
# git
#
alias ga='git add'
alias gap='git add -p'
alias gaa='git add -A'
alias gall='git add -A'
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias gs='git status'
# status short
alias gss='git status -s'
alias gp='git push'
alias gpo='git push origin'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gct='git checkout --track'
alias gcpd='git checkout master; git pull; git branch -D'
alias gl="git log"
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gls="git shortlog"
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
alias gst="git stash"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gh='cd "$(git rev-parse --show-toplevel)"'
# Show untracked files
alias gu='git ls-files . --exclude-standard --others'

# =====================================
# other stuff
#
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# opens a log file, ready for edits, with a current date
alias did="vim +'normal Go' +'r!date' ~/did.txt"

# line wrapping in terminal
alias nowrap="printf '\033[?7l'"
alias wrap="printf '\033[?7h'"

# fd - https://github.com/sharkdp/fd
alias fd='fdfind'
