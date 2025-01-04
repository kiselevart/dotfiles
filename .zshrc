# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Powerlevel10k theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Update PATH for TeX, C++ includes, and libraries
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="/opt/homebrew/bin/python:$PATH"
export PATH="/Users/kisel/.cargo/bin:$PATH"
export CPLUS_INCLUDE_PATH="/opt/homebrew/include:$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"
export GPG_TTY=$(tty)

# Source fzf, zsh-autosuggestions, and zsh-syntax-highlighting
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up pipx binary path
export PATH="$PATH:/Users/kisel/.local/bin"

# Conda initialize block (automatically managed by conda init)
# __conda_setup="$('/Users/kisel/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/kisel/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/kisel/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/kisel/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# Initialize zoxide and set alias
eval "$(zoxide init zsh)"export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/postgresql@16/lib:$DYLD_LIBRARY_PATH"

alias cd="z"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
