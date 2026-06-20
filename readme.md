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

## ⚠️ 必须的手动介入步骤 (Manual Steps)

虽然脚本完成了 99% 的自动化，但由于网络环境或权限原因，**执行完 `./prepare_all.sh` 后，你必须手动完成以下操作**：

1. **重启 iTerm2**：请彻底退出 iTerm2（按 `Cmd + Q`），然后重新打开它，以确保所有 Zsh 环境变量、动态配置的字体和颜色正确加载生效。
2. **配置 SSH 密钥 (可选)**：如果脚本为你**新生成了密钥**，你的公钥已自动复制，并且浏览器已自动打开 GitHub SSH 设置页面，请直接在网页上 `Cmd + V` 粘贴并保存。
   * **如果使用的是旧密钥**：
     * 若该旧密钥以前**已经**添加到 GitHub 中，你**不需要**做任何操作。
     * 若该旧密钥**从未**在当前 GitHub 账号配置过，则需要手动复制并添加。
   * **如何验证自己是否需要配置？**
     在终端执行测试命令：`ssh -T git@github.com`
     * 如果返回 `... successfully authenticated ...`，说明旧密钥有效，直接跳过此步。
     * 如果返回 `Permission denied (publickey)`，则说明需要配置。
   * **如何手动复制公钥并添加到 GitHub？**
     1. 在终端执行命令将公钥复制到剪贴板：`pbcopy < ~/.ssh/id_ed25519.pub`（如果使用的是 rsa，则替换为 `id_rsa.pub`）。
     2. 前往 GitHub SSH 设置页面：[https://github.com/settings/keys](https://github.com/settings/keys)。
     3. 点击 "New SSH key"，随意输入一个 Title（如 Mac-MyEnvs），然后将内容 `Cmd + V` 粘贴到 Key 框内并保存。
