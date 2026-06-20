#!/bin/bash

# ==========================================
# MyEnvs 一键环境配置脚本
# ==========================================

# 遇到错误即停止运行
set -e

echo "🚀 开始一键配置环境..."

# 确保所有脚本具有可执行权限
chmod +x ./install_brew.sh
chmod +x ./prepare_ssh.sh
chmod +x ./prepare_tmux.sh
chmod +x ./prepare_zsh.sh
chmod +x ./prepare_nvim.sh
chmod +x ./prepare_antigravity.sh

echo "----------------------------------------"
echo "🍺 1. 检查并配置 Brew"
./install_brew.sh

echo "----------------------------------------"
echo "🔐 2. 检查并配置 SSH 密钥与环境"
./prepare_ssh.sh

echo "----------------------------------------"
echo "🪟 3. 检查并配置 Tmux"
./prepare_tmux.sh

echo "----------------------------------------"
echo "🐚 3. 检查并配置 Zsh (增量配置)"
./prepare_zsh.sh

echo "----------------------------------------"
echo "📝 4. 检查并配置 Nvim"
./prepare_nvim.sh

echo "----------------------------------------"
echo "🤖 5. 检查并安装 Antigravity CLI"
./prepare_antigravity.sh

echo "----------------------------------------"
echo "✅ 所有环境配置完成！"
echo "请执行 'source ~/.zshrc' 或重启终端使所有配置生效。"
