# MyEnvs - 个人 Mac 极客环境一键装配库

这是一个高度自动化的个人环境配置库。支持**幂等执行**（重复运行不报错、不覆盖已有的增量修改），支持快速在全新的 macOS 上恢复习惯的开发环境。

## 🚀 快速开始（一键安装）

```bash
cd ~/code/MyEnvs
./prepare_all.sh
```

**`prepare_all.sh` 执行流程**：
1. **Brew** (`install_brew.sh`)：检查并安装 Homebrew 及常用环境变量。
2. **SSH 环境** (`prepare_ssh.sh`)：自动检测并生成极安全的 `ed25519` 密钥，自动拷贝公钥至剪贴板并唤起 GitHub 页面；同时挂载 SSH 防掉线与秒连复用机制 (Multiplexing)。
3. **Tmux** (`prepare_tmux.sh`)：自动同步全局剪贴板与 Vim 习惯键位。
4. **Zsh + p10k** (`prepare_zsh.sh`)：增量挂载 `.zshrc`（含 curlproxy 等快捷别名），全自动安装 MesloLGS NF 字体，自动配置 Terminal 渲染并恢复绝美 p10k 终端外观。
5. **Neovim** (`prepare_nvim.sh`)：安全备份本机配置，并同步你熟悉的 vim 环境。
6. **Antigravity CLI** (`prepare_antigravity.sh`)：通过代理环境自动极速拉取并安装 Antigravity AI 编程助手终端工具。

---
*注：本库的所有 Shell 脚本均已改造为“增量操作”或“前置存在检测”，请放心随时反复执行更新。*
