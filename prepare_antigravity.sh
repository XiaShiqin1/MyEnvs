#!/bin/bash

echo "🤖 开始配置 Antigravity CLI..."

# 检查是否已经安装
if command -v agy &> /dev/null; then
    echo "✅ Antigravity CLI (agy) 已安装，跳过。"
else
    echo "⚠️ 检测到未安装 Antigravity CLI，正在通过代理下载安装脚本..."
    
    # 使用用户提供的 proxy 环境下载并安装
    HTTPS_PROXY=http://127.0.0.1:7890 HTTP_PROXY=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 curl -fsSL https://antigravity.google/cli/install.sh -o /tmp/antigravity-install.sh
    
    if [ -f "/tmp/antigravity-install.sh" ]; then
        echo "✅ 下载成功！开始执行安装..."
        bash /tmp/antigravity-install.sh
        rm -f /tmp/antigravity-install.sh
    else
        echo "❌ 下载失败，请检查你的代理 (127.0.0.1:7890) 是否正常运行！"
    fi
fi

echo "Antigravity CLI 配置执行完毕。"
