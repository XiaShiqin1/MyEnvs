#!/bin/bash

echo "🔐 开始配置 SSH 环境..."

# 1. 确保 SSH 基础目录和连接复用目录存在
mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh

# 2. 同步优化的 SSH 配置文件
if [ -f "./ssh_config" ]; then
    echo "同步优化的 ~/.ssh/config..."
    cp ./ssh_config ~/.ssh/config
    chmod 600 ~/.ssh/config
fi

# 3. 智能处理 SSH 密钥 (保障安全，决不能把私钥放进 Git 库)
KEY_FILE="$HOME/.ssh/id_ed25519"

if [ -f "$KEY_FILE" ]; then
    echo "✅ 本机已存在 SSH 密钥 ($KEY_FILE)，跳过生成。"
else
    echo "⚠️ 检测到本机没有 SSH 密钥，正在为你自动生成（算法: ed25519）..."
    # 自动静默生成密钥，不设置 passphrase
    ssh-keygen -t ed25519 -f "$KEY_FILE" -N "" -q
    
    echo "✅ 密钥生成完毕！"
    
    # 将公钥自动复制到剪贴板
    if command -v pbcopy &> /dev/null; then
        cat "${KEY_FILE}.pub" | pbcopy
        echo "📋 你的【公钥】已经自动复制到了剪贴板！"
        echo "🌐 正在为你打开 GitHub 设置页面..."
        # 等待2秒让用户看清楚提示
        sleep 2
        open "https://github.com/settings/ssh/new"
        echo "👉 请在打开的网页中直接 `Cmd + V` 粘贴并保存即可！保存后你就可以一键 clone 和 push 了。"
    else
        echo "请手动复制以下公钥并添加到 GitHub:"
        cat "${KEY_FILE}.pub"
    fi
fi

echo "SSH 配置执行完毕。"
