if not set -q fish_shell_initialized
    set -Ux fish_shell_initialized
    echo -n Setting abbreviations...

    abbr alpine-fish 'docker run -v (pwd):/local-dir --rm --name alpine-fish -it colstrom/abbr'
    abbr bbi 'brew install'
    abbr be 'bundle exec'
    abbr bi 'bundle install'
    abbr brm 'brew uninstall'
    abbr bs 'brew search'
    abbr cht 'cht.sh'
    abbr cht-shell 'cht.sh --shell'
    abbr dap "dotnet add package"
    abbr dcl 'docker-compose logs -f'
    abbr dco 'docker-compose'
    abbr dcu 'docker-compose up -d'
    abbr ssh-kg-ed25519 'ssh-keygen -a 100 -t ed25519 -C "jonas.helgemo@webstep.no" -f id_ed25519'
    abbr ssh-kg-rsa 'ssh-keygen -a 100 -t rsa -C "jonas.helgemo@webstep.no" -f id_rsa'
    abbr dr "dotnet run"
    abbr gv 'tmuxinator start gv'
    abbr i 'idea'
    abbr planck-flash 'wally-cli (ls -t ~/Downloads/planck*.bin | head -1)'
    abbr si 'say -v Nora'
    abbr st 'git status'
    abbr ubuntu 'docker run -it --rm ubuntu'
    abbr ubuntu-fish 'docker run -v (pwd):/local-dir --rm --name ubuntu-fish -it colstrom/fish:ubuntu'
    abbr vsh 'vaulted shell -n'
    abbr weeknumber 'gdate +%V -d today '
    abbr dev-proxy 'c'
    abbr plex-aws-start 'aws ec2 start-instances --instance-ids "i-0c7f09bb38bc59b1a"'
    abbr plex-aws-stop 'aws ec2 stop-instances --instance-ids "i-0c7f09bb38bc59b1a"'
    abbr plex-aws-status 'aws ec2 describe-instance-status --instance-ids "i-0c7f09bb38bc59b1a"'
    echo 'Done ✨'
end

# Set paths
set -gx PATH $PATH /usr/sbin /usr/bin /sbin /bin $HOME/bin /usr/local/bin $HOME/.dapr/bin $HOME/src/go/bin $HOME/.cargo/bin $HOME/.asdf/shims/ $HOME/.asdf/bin/ $HOME/.asdf/installs/rust/stable/bin/ /Applications/Emacs.app/Contents/MacOS/ /Applications/Emacs.app/Contents/MacOS/bin/ $HOME/.emacs.d/bin/ ~/.local/bin

# Set CDPATH
set -gx CDPATH $CDPATH .

# Set Stowdir
set -gx STOW_DIR $HOME/dotfiles

# Golang
set -gx GOPATH $HOME/src/go

# Editor
set -gx EDITOR 'emacsclient -n -create-frame --alternate-editor=""'

# Java home
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/openjdk-11.0.1.jdk/Contents/Home

# z.lua
set -gx _ZL_MATCH_MODE 1

# Set global azure config dir (overrides in customer volumes)
set -gx AZURE_CONFIG_DIR ~/.azure

# GnuPG
set -gx GPG_TTY (tty)


# fzf use fd
#set -gx FZF_DEFAULT_OPS '--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
#set -gx FZF_DEFAULT_COMMAND 'set'
#set -gx FZF_CTRL_T_COMMAND 'fd --type f'
# set -gx FZF_ALT_C_COMMAND 'fd --ntype d'
# set -gx FZF_LEGACY_KEYBINDINGS 0
# set -gx FZF_COMPLETE 0

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
alias bb='cat (string match -v .Brewfile.lock.json -- .Brewfile*) | brew bundle --file=-'
alias git='hub'
alias tf='terraform'
alias uuid='uuidgen  | awk \'{print tolower($0)}\''
alias cat='bat'
alias less='bat'
alias more='bat'
alias sed='gsed'
alias ls='exa'
alias atari='hatari -c ~/.config/hatari/hatari.cfg'
alias notifyme='echo "✅" | mail -s "🦄🌈✨" jonas.helgemo@webstep.no'

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

# https://github.com/wfxr/forgit git extras
source ~/.config/fish/plugins/forgit.plugin.fish

# Starship must be last
eval (starship init fish)
