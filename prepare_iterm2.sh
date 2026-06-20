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

# 使用 Python 脚本修改现有的 iTerm2 配置，实现所有 Profile 的静默、一键更改
echo "⚙️  更新 iTerm2 首选项 (默认使用 MesloLGS NF 字体与深色背景)..."
python3 - << 'EOF'
import subprocess
import plistlib
import os
import sys

def main():
    temp_plist = "/tmp/temp_iterm2_myenvs.plist"
    
    # 导出当前的 iTerm2 配置到临时文件，以便安全修改
    try:
        subprocess.run(["defaults", "export", "com.googlecode.iterm2", temp_plist], check=True, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        print("⚠️ 无法读取 iTerm2 配置文件，可能是尚未初始化。")
        sys.exit(0)
    
    with open(temp_plist, "rb") as f:
        pl = plistlib.load(f)
    
    modified = False
    if "New Bookmarks" in pl:
        for bm in pl["New Bookmarks"]:
            # 更新字体配置
            bm["Normal Font"] = "MesloLGS-NF-Regular 14"
            bm["Non Ascii Font"] = "MesloLGS-NF-Regular 14"
            bm["Use Non-ASCII Font"] = False
            
            # 更新背景颜色为非常深的暗色
            bm["Background Color"] = {
                "Red Component": 0.05,
                "Green Component": 0.05,
                "Blue Component": 0.05,
                "Alpha Component": 1.0,
                "Color Space": "sRGB"
            }
            # 更新前景色为亮白
            bm["Foreground Color"] = {
                "Red Component": 0.90,
                "Green Component": 0.90,
                "Blue Component": 0.90,
                "Alpha Component": 1.0,
                "Color Space": "sRGB"
            }
            modified = True
            
    if modified:
        with open(temp_plist, "wb") as f:
            plistlib.dump(pl, f)
        # 将修改后的配置重新导入，这会让 macOS 的 cfprefsd 识别到更改
        subprocess.run(["defaults", "import", "com.googlecode.iterm2", temp_plist], check=True)
        print("✅ 成功修改 iTerm2 配置！")
    else:
        print("⚠️ 未找到任何终端 Profile，已跳过。")
        
    if os.path.exists(temp_plist):
        os.remove(temp_plist)

if __name__ == "__main__":
    main()
EOF

echo "💡 提示：如果发现 iTerm2 未立刻生效，请完全退出 iTerm2 (Cmd+Q) 后重新打开即可应用新字体和深色背景。"
