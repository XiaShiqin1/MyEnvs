# Antigravity Rules

- **代码提交规范**：每次帮助用户提交代码时，不要直接在默认主分支（如 master/main）上 commit 和 push。必须先创建一个具有描述性的新分支（如 `feat/xxx` 或 `fix/xxx`），然后将代码 commit 到新分支并推送到远程。
- **全自动 PR 规范（需确认）**：代码 push 到远端后，**不要**自动直接发起 Pull Request，以避免产生过多细碎的 PR。应当在用户连续提出需求并完成一阶段开发后，**经用户明确确认后**，再使用 Github CLI 命令（`gh pr create --fill` 等）自动发起 Pull Request，并自动补充好 PR 的标题和正文（包含改动上下文）。在使用 `gh` 之前，可以尝试检查命令是否存在。
