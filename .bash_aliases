alias lal='ls -al'

# alias commands for git
alias gs='git status'
alias ga='git add'
alias gd="git diff"
alias gaa='git add --all'
alias gcm='git commit -m'G
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

# function and associated alias to refresh and source $HOME directory
fn_refreshbash() {
    local src_dir="$HOME/git-repos/bim/wsl-ubuntu"
    local files=(
        ".bash_aliases"
        ".bashrc"
        ".git-completion.bash"
        ".git-prompt.sh"
        ".gitignore"
        ".vimrc"
        "bootstrap.sh"
        "locale"
        "install-scripts"
    )

    if [[ ! -d "$src_dir" ]]; then
        echo "Source directory $src_dir does not exist."
        return 1
    fi

    for file in "${files[@]}"; do
        local src="$src_dir/$file"
        local dest="$HOME/$file"
        if [[ -e "$src" ]]; then
            if [[ -d "$src" ]]; then
                rm -rf "$dest"   # CAREFUL: This deletes the destination directory first!
                cp -r "$src" "$dest"
            else
                cp "$src" "$dest"
            fi
            echo "Copied $file to $HOME/"
        else
            echo "Warning: $file does not exist in $src_dir"
        fi
    done

    # Source the new .bashrc
    if [[ -f "$HOME/.bashrc" ]]; then
        # shellcheck source=/dev/null
        source "$HOME/.bashrc"
        echo "Sourced $HOME/.bashrc"
    else
        echo "No .bashrc found in $HOME to source."
    fi
}

alias refreshbash='fn_refreshbash'

