#!/bin/bash

# ==========================================
# MyEnvs 一键环境配置脚本
# ==========================================

# 遇到错误即停止运行
set -e

echo "🌐 设置全局代理以便加速下载 (如果不需要代理，可注释掉以下三行)..."
export all_proxy="socks5://127.0.0.1:7890"
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

echo "🚀 开始一键配置环境..."

# 确保所有脚本具有可执行权限
chmod +x ./install_brew.sh
chmod +x ./prepare_ssh.sh
chmod +x ./prepare_tmux.sh
chmod +x ./prepare_zsh.sh
chmod +x ./prepare_nvim.sh
chmod +x ./prepare_antigravity.sh
chmod +x ./prepare_iterm2.sh

echo "----------------------------------------"
echo "🐚 1. 检查并配置 Zsh (增量配置)"
./prepare_zsh.sh

echo "----------------------------------------"
echo "🍺 2. 检查并配置 Brew"
./install_brew.sh

echo "----------------------------------------"
echo "🔐 3. 检查并配置 SSH 密钥与环境"
./prepare_ssh.sh

echo "----------------------------------------"
echo "🪟 4. 检查并配置 Tmux"
./prepare_tmux.sh

echo "----------------------------------------"
echo "📝 5. 检查并配置 Nvim"
./prepare_nvim.sh

echo "----------------------------------------"
echo "🤖 6. 检查并安装 Antigravity CLI"
./prepare_antigravity.sh

echo "----------------------------------------"
echo "🖥️  7. 配置 iTerm2 (字体和背景)"
./prepare_iterm2.sh

echo "----------------------------------------"
echo "🧹 8. 清理 Zsh 补全缓存 (修复 compinit 报错)"
# 删除可能损坏的 brew services 补全软链接
rm -f /opt/homebrew/share/zsh/site-functions/_brew_services 2>/dev/null || true
# 清理 zsh 补全缓存，强制下次启动终端时重建
rm -f ~/.zcompdump* 2>/dev/null || true

echo "----------------------------------------"
echo "🎉 所有环境基础配置已完成！"
echo ""
echo "⚠️  【重要提示】为了让所有配置生效，请你手动执行以下操作："
echo ""
echo "  1️⃣  重启 iTerm2: 请按 \`Cmd + Q\` 完全退出 iTerm2 然后重新打开，以确保字体、颜色以及 Zsh 环境变量全部加载生效"
echo "  2️⃣  配置 SSH 密钥: 关于新旧密钥的校验和配置说明，请仔细阅读 readme.md 中的相关部分"
echo ""
echo "祝你编码愉快！🚀"
