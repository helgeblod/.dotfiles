if not set -q fish_shell_initialized
    set -Ux fish_shell_initialized
    echo -n Setting abbreviations...

    abbr alpine-fish 'docker run -v (pwd):/local-dir --rm --name alpine-fish -it colstrom/abbr'
    abbr be 'bundle exec'
    abbr bi 'bundle install'
    abbr bs 'brew search'
    abbr dcl 'docker-compose logs -f'
    abbr dco 'docker-compose'
    abbr dcu 'docker-compose up -d'
    abbr planck-flash 'wally-cli (ls -t ~/Downloads/planck*.bin | head -1)'
    abbr si 'say -v Nora'
    abbr st 'git status'
    abbr ubuntu 'docker run -it --rm ubuntu'
    abbr ubuntu-fish 'docker run -v (pwd):/local-dir --rm --name ubuntu-fish -it colstrom/fish:ubuntu'
    abbr weeknumber 'gdate +%V -d today '
    echo 'Done ✨'

end

# Set paths
set -gx PATH $PATH /usr/sbin /usr/bin /sbin /bin $HOME/bin /usr/local/bin $HOME/.dapr/bin $HOME/src/go/bin $HOME/.cargo/bin $HOME/.asdf/shims/ $HOME/.asdf/bin/ $HOME/.asdf/installs/rust/stable/bin/ /Applications/Emacs.app/Contents/MacOS/ /Applications/Emacs.app/Contents/MacOS/bin/ $HOME/.emacs.d/bin/ ~/.local/bin

# Set CDPATH
#set -gx CDPATH $CDPATH .

# Golang
set -gx GOPATH $HOME/src/go

# Editor
set -gx EDITOR 'emacsclient -n -create-frame --alternate-editor=""'

# z.lua
set -gx _ZL_MATCH_MODE 1

# Set global azure config dir (overrides in customer volumes)
set -gx AZURE_CONFIG_DIR ~/.azure

# GnuPG
set -gx GPG_TTY (tty)

# fzf-fish bindings
# \cf is Ctrl+f
set --universal fzf_fish_custom_keybindings
bind \cj '__fzf_search_current_dir'
bind \cr '__fzf_search_history'
# The following two key binding use Alt as an additional modifier key to avoid conflicts
bind \e\cl $__fzf_search_vars_cmd
bind \e\ck '__fzf_search_git_log'
bind \e\cj '__fzf_search_git_status'

# Aliases
alias g='hub'
alias bb='brew bundle --global'
alias tf='terraform'
alias uuid='uuidgen  | awk \'{print tolower($0)}\''
alias cat='bat'
alias less='bat'
alias more='bat'
alias ls='exa'
alias top='ytop'
alias htop='ytop'
alias ps='procs'
alias sed='sd'
alias du='dust'
alias grep='ripgrep'
alias tldr='tealdeer'

alias dev-proxy='caddy run --config ~/.caddy/Caddyfile'

################################################################################
# Load customer custom config if present in customer src folder
################################################################################
for file in ~/src/customer/*/*.fish
    # Add directory to CDPATH
    set -gx CDPATH $CDPATH (dirname $file)
    source $file
end

# asdf version manager
source /usr/local/opt/asdf/asdf.fish

# zoxide
zoxide init fish | source

# Starship must be last
eval (starship init fish)
