alias refreshbash='source ~/.bashrc'
alias lal='ls -al'

# alias commands for git
alias gs='git status'
alias ga='git add'
alias gd="git diff"
alias gaa='git add --all'
alias gcm='git commit -m'
alias gacm='git add-commit -m'
alias gchk='git checkout'
alias gchkb='git checkout -b'
alias gph='git push'
alias gpsh='git push'
alias gpl='git pull'
alias gl='git log --graph --decorate'
alias glo='git log --graph --oneline --decorate'
alias glor='git log --oneline --reverse'
alias grpo='git remote prune origin'
alias grv='git remote -v'

# cd to gitrepos parent folder and git pull on subdirectories
#alias gplrepos='cd ~/git-repos/;find ./bim ./work -type d -name .git -execdir sh -c "pwd && git pull && sleep 2.5" \;'

# alias commands for docker interaction
# note: --no-pager option retuns command back to the interactive shell prompt
alias startdocker='sudo systemctl start docker.socket docker.service && \
                    sudo systemctl status docker.service --no-pager'
alias stopdocker='sudo systemctl stop docker.socket docker.service && \
                    sudo systemctl status docker.service --no-pager'
alias di='sudo docker images'
                    
# cd git top level dirs
alias cdgitrepos='cd ~/git-repos'
alias cdgrb='cd ~/git-repos/bim'

