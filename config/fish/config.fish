if not set -q fish_shell_initialized
    set -Ux fish_shell_initialized
    echo -n Setting abbreviations...
    abbr alpine-fish 'docker run -v (pwd):/local-dir --rm --name alpine-fish -it colstrom/fish:alpine'
    abbr be 'bundle exec'
    abbr bi 'bundle install'
    abbr bs 'brew search'
    abbr dcl 'docker-compose logs -f'
    abbr dco 'docker-compose'
    abbr dcu 'docker-compose up -d'
    abbr planck-flash 'wally-cli (ls -t ~/Downloads/planck*.bin | head -1)'
    abbr si 'say -v Nora'
    abbr st 'git status | fpp'
    abbr ubuntu 'docker run -it --rm ubuntu'
    abbr ubuntu-fish 'docker run -v (pwd):/local-dir --rm --name ubuntu-fish -it colstrom/fish:ubuntu'
    abbr weeknumber 'gdate +%V -d today '
    echo 'Done ✨'

end

# Set paths
set -gx PATH $PATH /usr/sbin /usr/bin /sbin /bin $HOME/bin /usr/local/bin $HOME/.dapr/bin $HOME/src/go/bin $HOME/.cargo/bin $HOME/.asdf/shims/ $HOME/.asdf/bin/ $HOME/.asdf/installs/rust/stable/bin/ /Applications/Emacs.app/Contents/MacOS/ /Applications/Emacs.app/Contents/MacOS/bin/ $HOME/.emacs.d/bin/ ~/.local/bin

# Set CDPATH
set -gx CDPATH $CDPATH .

# Golang
set -gx GOPATH $HOME/src/go

# Editor
set -gx EDITOR 'emacsclient -n -create-frame --alternate-editor=""'

# Set global azure config dir (overrides in customer volumes)
set -gx AZURE_CONFIG_DIR ~/.azure

# GnuPG
set -gx GPG_TTY (tty)

# Unset AWS_PROFILE
set -e AWS_PROFILE

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# Alias
function alias_if_available
    if type -qs $argv[2]
        alias $argv[1]=$argv[2]
    end
end

alias dotedit='emacsclient -n --alternate-editor="" (fd -E "dotbot" -E "alfred" . ~/.dotfiles* | fzf)'
alias magit='emacsclient -nw -e "(magit-status)"'
alias e='emacsclient -n --alternate-editor=""'
alias_if_available ls exa
alias_if_available g hub
alias_if_available ls exa
alias_if_available ls exa
alias_if_available tf terraform
alias_if_available cat bat
alias_if_available less bat
alias_if_available more bat
alias_if_available tf terraform
alias_if_available top htop
#alias_if_available sed sd
alias_if_available ps procs
alias_if_available du dust
alias_if_available grep ripgrep
alias_if_available tldr tealdeer

if type -qs "brew"
    alias bb='brew bundle --global'
end

if type -qs "uuidgen"
    alias uuid='uuidgen  | awk \'{print tolower($0)}\''
end

if type -qs "caddy"
    alias dev-proxy='caddy run --config ~/.caddy/Caddyfile --watch'
end

if type -qs "fzf"
    alias dev-proxy='caddy run --config ~/.caddy/Caddyfile'
end



################################################################################
# Load customer custom config if present in customer src folder
################################################################################
for file in ~/src/customer/*/*.fish
    # Add directory to CDPATH
    set -gx CDPATH $CDPATH (dirname $file)
    source $file
end

# asdf version manager
if type -qs "asdf"
    source /usr/local/opt/asdf/asdf.fish
end


# zoxide
if type -qs "zoxide"
    zoxide init fish | source
end

# Starship must be last
if type -qs "starship"
    eval (starship init fish)
end
