# ---------------------------------------------------------
# 增量配置文件
# 该文件由 ~/.zshrc 自动 source，请将你个人的环境变量和 alias 放在这里
# ---------------------------------------------------------

# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# 你的个人快捷命令 (Aliases)
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vim='nvim'
alias vi='nvim'
alias tmux='tmux -u'
