# Plugins {{{
# ==============================================================================

    # Load the Antibody plugin manager for zsh.
    # see https://getantibody.github.io/
    source <(antibody init)

    # Setup required env var for oh-my-zsh plugins
    export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh"

    antibody bundle ohmyzsh/ohmyzsh
    antibody bundle ohmyzsh/ohmyzsh path:plugins/docker
    antibody bundle ohmyzsh/ohmyzsh path:plugins/docker-compose
    antibody bundle ohmyzsh/ohmyzsh path:plugins/git-flow # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-flow / https://github.com/nvie/gitflow

    # Other bundles
    antibody bundle djui/alias-tips
    # antibody bundle zsh-users/zsh-autosuggestions
    antibody bundle jessarcher/zsh-artisan # https://github.com/jessarcher/zsh-artisan

    # Theme
    # antibody bundle dracula/zsh
    # antibody bundle ohmyzsh/ohmyzsh path:themes/af-magic.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/agnoster.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/amuse.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/arrow.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/bira.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/clean.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/cloud.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/darkblood.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/edvardm.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/fishy.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/jonathan.zsh-theme
    # antibody bundle ohmyzsh/ohmyzsh path:themes/kiwi.zsh-theme
    antibody bundle ohmyzsh/ohmyzsh path:themes/miloshadzic.zsh-theme

    # This needs to be the last bundle.
    # antibody bundle zsh-users/zsh-syntax-highlighting

# }}}

# Configuration {{{
# ==============================================================================

    HYPHEN_INSENSITIVE="true"
    ENABLE_CORRECTION="false"
    COMPLETION_WAITING_DOTS="true"
    HIST_STAMPS="yyyy-mm-dd"
    DISABLE_AUTO_TITLE="true"

    typeset -U path cdpath fpath

    path=(
        $HOME/.local/bin
        $HOME/.bin
        $HOME/bin
        $HOME/.composer/vendor/bin
        $HOME/.go/bin
        ./vendor/bin
        $path
    )

    setopt auto_cd
    cdpath=(
        $HOME/workspace
    )

    zstyle ':completion:*' group-name ''
    zstyle ':completion:*:descriptions' format %d
    zstyle ':completion:*:descriptions' format %B%d%b
    zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
            'local-directories named-directories'

    export EDITOR='vim'
    # export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'

    unsetopt sharehistory

# }}}

# Aliases & Functions {{{
# ==============================================================================

    [ -f ~/.shell_aliases ] && source ~/.shell_aliases
    [ -f ~/.shell_aliases.zsh ] && source ~/.shell_aliases.zsh

    [ -f ~/.shell_extensions ] && source ~/.shell_extensions
    [ -f ~/.shell_extensions.zsh ] && source ~/.shell_extensions.zsh

# }}}

# Interactive shell startup scripts {{{
# ==============================================================================

    if [[ $- == *i* && $0 == *zsh* && -f ~/scripts/login.sh ]]; then
        ~/scripts/login.sh
    fi

# }}}
