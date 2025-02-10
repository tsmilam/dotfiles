# --- System Configuration ---
source /etc/profile

export TERM="xterm-256color"
export EDITOR="vim"

# Update PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH:~/.fzf:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/.local/bin:~/.fzf/bin"

# --- Antigen Configuration ---
source $HOME/.antigen/antigen.zsh

# --- Spaceship Kubernetes Module Configuration ---
SPACESHIP_KUBECTL_SHOW=true          # Ensure kubectl is shown

# Display username always
SPACESHIP_USER_SHOW=always

# Hide context, namespace, and user to prevent "default" from appearing
SPACESHIP_KUBECTL_SHOW_CONTEXT=false
SPACESHIP_KUBECTL_SHOW_NAMESPACE=true
SPACESHIP_KUBECTL_SHOW_USER=false

# Show the Kubernetes cluster name
SPACESHIP_KUBECTL_SHOW_CLUSTER=true

SPACESHIP_USER_COLOR="green"

# Set Kubernetes symbol
SPACESHIP_KUBECTL_SYMBOL="☸️  "

# Set Kubernetes symbol color
SPACESHIP_KUBECTL_COLOR="blue"
# --- End of Spaceship Kubernetes Module Configuration ---

# Kubernetes Aliases and Completion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)

  # Kubernetes Context Switcher (kcs) - Using FZF
  kcs() {
    local config_dir=~/.kube
    local selection=$(ls "$config_dir" | grep -v '^config$\|^cache$\|^ca-certs$\|^kubectx$\|^kubens$' | fzf --height=50% --reverse --border --inline-info)

    if [[ -n "$selection" ]]; then
      export KUBECONFIG="$config_dir/$selection"
      echo "Switched kubeconfig to: $selection"
    fi
  }

  # Kubernetes Namespace Switcher (kns) - Using FZF
  kns() {
    if [[ -z "$1" ]]; then
      local ns=$(kubectl get ns --no-headers | awk '{print $1}' | fzf --height=50% --reverse --border --inline-info)
      if [[ -n "$ns" ]]; then
        kubectl config set-context --current --namespace="$ns"
        echo "Switched namespace to: $ns"
      fi
    else
      kubectl config set-context --current --namespace="$1"
      echo "Switched namespace to: $1"
    fi
  }
fi

# Load Bundles (Plugins) with Antigen
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the Spaceship Theme
antigen theme denysdovhan/spaceship-prompt

# Apply the Configuration
antigen apply

# --- Additional Configurations ---
unsetopt share_history
autoload -Uz copy-earlier-word
zle -N copy-earlier-word

# Enable command completion
autoload -U compinit && compinit

# Aliases
alias 'ubuntu-release'="lsb_release -a"
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias k='kubectl'

# Directory Colors
eval "$(dircolors ~/.dircolors)"
autoload -U colors && colors

# fzf Configuration
export FZF_TMUX=0
export FZF_DEFAULT_OPTS="--height 100% --reverse"

