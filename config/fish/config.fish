if not set -q fish_shell_initialized
    set -Ux fish_shell_initialized
    echo -n Setting abbreviations...
    abbr alpine-fish 'docker run -v (pwd):/local-dir --rm --name alpine-fish -it helgeblod/alpine-fish'
    abbr bi 'bundle install'
    abbr bs 'brew search'
    abbr dcl 'docker compose logs -f'
    abbr dco 'docker compose'
    abbr dcu 'docker compose up -d'
    abbr planck-flash 'wally-cli (ls -t ~/Downloads/planck*.bin | head -1)'
    abbr si 'say -v Nora'
    abbr st 'git status'
    abbr ubuntu 'docker run -it --rm ubuntu'
    abbr ubuntu-fish 'docker run -v (pwd):/local-dir --rm --name ubuntu-fish -it colstrom/fish:ubuntu'
    abbr weeknumber 'gdate +%V -d today '
    echo 'Done ✨'
end

# Set paths
#set -gx PATH $PATH /usr/sbin /usr/bin /sbin /bin $HOME/bin /usr/local/bin $HOME/.dapr/bin $HOME/src/go/bin $HOME/.cargo/bin $HOME/.asdf/shims/ $HOME/.asdf/bin/ $HOME/.asdf/installs/rust/stable/bin/ /Applications/Emacs.app/Contents/MacOS/ /Applications/Emacs.app/Contents/MacOS/bin/ $HOME/.emacs.d/bin/ ~/.local/bin
set -gx PATH $HOME/bin $HOME/.rbenv/shims $HOME/.asdf/bin $HOME/.asdf/shims /opt/homebrew/opt/ruby/bin /opt/homebrew/bin /opt/homebrew/sbin /usr/bin /bin /usr/sbin /sbin /Library/Apple/usr/bin /usr/local/share/dotnet $HOME/.dotnet/tools /usr/local/MacGPG2/bin /usr/local/bin /Library/Frameworks/Mono.framework/Versions/Current/Commands/Users/jonashelgemo/.dapr/bin $HOME/src/go/bin $HOME/.cargo/bin /Applications/Emacs.app/Contents/MacOS/ /Applications/Emacs.app/Contents/MacOS/bin/ $HOME/.emacs.d/bin/ $HOME/.local/bin $HOME/Library/Python/3.8/bin /usr/local/share/dotnet/x64/ ./target/release/ /Library/TeX/texbin/


# Set CDPATH
set -gx CDPATH $CDPATH .

# Golang
set -gx GOPATH $HOME/src/go

# Editor
set -gx EDITOR 'jove'

# Env
set -gx ENV 'dev'

# Set global azure config dir (overrides in customer volumes)
set -gx AZURE_CONFIG_DIR ~/.azure

# Set gcloud config (override customer settings)
set -gx GCP_PROJECT ""
set -gx CLOUDSDK_CONFIG ""

# GnuPG
set -gx GPG_TTY (tty)

# Unset AWS_PROFILE
set -e AWS_PROFILE

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

function atarist
    pushd ~/Games/AtariST
    hatari -c ~/.dotfiles-local/hatari/hatari.cfg (fzf)
    popd
end

# Alias
function alias_if_available
    if type -qs $argv[2]
        alias $argv[1]=$argv[2..-1]
    end
end

function dev-proxy
    set current_dir (pwd)
    cd ~/.dotfiles-local/traefik/
    op run --env-file=.op_env -- docker compose up -d
    cd $current_dir
end


# .. - cd .., ... - cd ../.. etc
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

abbr --add dotdot --regex '^\.\.+$' --function multicd

alias be='e ~/.dotfiles-local/homebrew/Brewfile'
alias cb='cargo build'
alias ci='cargo install'
alias cip='cargo install --path'
alias cr='cargo run'
alias date='gdate'
alias de='emacsclient -n --alternate-editor="" (fd -E "dotbot" -E "alfred" . ~/.dotfiles* | fzf)'
alias dev-env='set -x ENV dev; direnv reload'
alias docker-sh='docker exec -it (gum choose (docker ps --format "{{.Names}}")) bash'
alias e='emacsclient -n --alternate-editor=""'
alias iarch='arch -x86_64'
alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias magit='emacsclient -nw -e "(magit-status)"'
alias ope-nm='op run --env-file=.op_env --no-masking --'
alias ope='op run --env-file=.op_env --'
alias opr-nm='op run --no-masking --'
alias opr='op run --'
alias prod-env='set -x ENV prod;direnv reload'
alias watcher='hwatch -c'
alias docker-shell='docker run -v (pwd):/local-dir --rm --name docker-shell -it'

#alias_if_available sed sd
alias_if_available bro tldr
alias_if_available cp fcp
alias_if_available du dust
alias_if_available grep ripgrep
alias_if_available less bat
alias_if_available more bat
alias_if_available ps procs
alias_if_available tf terraform
alias_if_available tldr tealdeer
alias_if_available top htop

if type -qs exa
    alias ls='exa --icons'
end

if type -qs bat
    alias cat='bat -pp --theme="Nord"'
end

if type -qs "brew"
    alias bb='brew bundle --global'
end

if type -qs "uuidgen"
    alias uuid='uuidgen  | awk \'{print tolower($0)}\''
end

################################################################################
# Load customer custom config if present in customer src folder
################################################################################
for file in ~/src/customer/*/*.fish
    # Add directory to CDPATH
    set -gx CDPATH $CDPATH (dirname $file)
    set -gx PATH $PATH (dirname $file)/bin
    source $file
end

# asdf version manager
if type -qs "asdf"
    source /usr/local/opt/asdf/libexec/asdf.fish
end

# 1Password-cli
if type -qs "op"
    op completion fish | source
end

# zoxide
if type -qs "zoxide"
    zoxide init fish --cmd z | source
end



# Starship must be last
 if type -qs "starship"
     starship init fish | source
 end

# direnv hook fish | source

# if type -qs "oh-my-posh"
#     # Themes here: https://github.com/JanDeDobbeleer/oh-my-posh/tree/main/themes
#     oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/festivetech.omp.json | source # christmas 🎅
#     #oh-my-posh init fish | source

# end
