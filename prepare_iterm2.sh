#!/bin/bash

# ==========================================
# MyEnvs iTerm2 配置脚本 (字体和背景颜色)
# ==========================================

# 遇到错误即停止运行
set -e

echo "🚀 开始配置 iTerm2 (设置 MesloLGS NF 字体和暗色背景)..."

# 检查当前是否在 macOS 环境
if [ "$(uname)" != "Darwin" ]; then
    echo "⚠️ 非 macOS 环境，跳过 iTerm2 配置。"
    exit 0
fi

# 如果没有安装 iTerm2，可以先检查
if [[ ! -d "/Applications/iTerm.app" ]] && [[ ! -d "$HOME/Applications/iTerm.app" ]]; then
    echo "⚠️ 未找到 iTerm2 应用程序，跳过配置。"
    exit 0
fi

# 确保所有字体已安装
echo "📥 确保字体已被安装..."
if [ -d "./resource" ]; then
    FONT_DIR="$HOME/Library/Fonts"
    for font in ./resource/Meslo*.ttf; do
        if [ -f "$font" ]; then
            font_name=$(basename "$font")
            if [ ! -f "$FONT_DIR/$font_name" ]; then
                echo "   安装字体: $font_name"
                cp "$font" "$FONT_DIR/"
            fi
        fi
    done
fi

# 使用 iTerm2 的 Dynamic Profiles 功能来覆盖默认配置，这样可以立即生效并且不会因为 iTerm2 退出而丢失配置
echo "⚙️  更新 iTerm2 首选项 (默认使用 MesloLGS NF 字体与深色背景)..."
python3 - << 'EOF'
import subprocess
import json
import os

def main():
    dynamic_guid = "myenvs-dynamic-profile-v1"

    profile_data = {
        "Profiles": [
            {
                "Name": "MyEnvs Default",
                "Guid": dynamic_guid,
                "Normal Font": "MesloLGS-NF-Regular 14",
                "Non Ascii Font": "MesloLGS-NF-Regular 14",
                "Use Non-ASCII Font": False,
                "Background Color": {
                    "Red Component": 0.17,
                    "Green Component": 0.17,
                    "Blue Component": 0.17,
                    "Alpha Component": 1.0,
                    "Color Space": "sRGB"
                },
                "Foreground Color": {
                    "Red Component": 0.90,
                    "Green Component": 0.90,
                    "Blue Component": 0.90,
                    "Alpha Component": 1.0,
                    "Color Space": "sRGB"
                },
                "Cursor Color": {
                    "Red Component": 0.65,
                    "Green Component": 0.65,
                    "Blue Component": 0.65,
                    "Alpha Component": 1.0,
                    "Color Space": "sRGB"
                },
                "Cursor Text Color": {
                    "Red Component": 0.10,
                    "Green Component": 0.10,
                    "Blue Component": 0.10,
                    "Alpha Component": 1.0,
                    "Color Space": "sRGB"
                }
            }
        ]
    }

    dynamic_profiles_dir = os.path.expanduser("~/Library/Application Support/iTerm2/DynamicProfiles")
    os.makedirs(dynamic_profiles_dir, exist_ok=True)
    
    profile_path = os.path.join(dynamic_profiles_dir, "MyEnvsProfileOverride.json")
    with open(profile_path, "w") as f:
        json.dump(profile_data, f, indent=2)
        
    # 将此动态 Profile 设置为默认
    try:
        subprocess.run(["defaults", "write", "com.googlecode.iterm2", "Default Bookmark Guid", "-string", dynamic_guid], check=True)
        print(f"✅ 成功生成 iTerm2 动态配置并将 'MyEnvs Default' 设为默认！")
    except Exception as e:
        print(f"⚠️ 生成了动态配置，但设置为默认时遇到错误: {e}")

if __name__ == "__main__":
    main()
EOF

echo "💡 提示：动态配置应该已经立刻生效，如果当前窗口没有变化，可以尝试新开一个 Tab (Cmd+T)。"
