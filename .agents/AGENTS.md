# Antigravity Rules

- **代码提交规范**：每次帮助用户提交代码时，不要直接在默认主分支（如 master/main）上 commit 和 push。必须先创建一个具有描述性的新分支（如 `feat/xxx` 或 `fix/xxx`），然后将代码 commit 到新分支并推送到远程。
- **全自动 PR 规范**：代码 push 到远端后，不要让用户手动去点链接，必须使用 Github CLI 命令（`gh pr create --fill` 等）自动发起 Pull Request，并自动补充好 PR 的标题和正文（包含改动上下文）。在使用 `gh` 之前，可以尝试检查命令是否存在。
