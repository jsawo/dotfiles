# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jacek/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/jacek/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jacek/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/jacek/.fzf/shell/key-bindings.bash"
