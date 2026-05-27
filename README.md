# Codex Obsidian Sync

一个独立的 Codex 会话同步脚本，用来把本机 Codex 对话日志持续同步到 Obsidian Markdown 笔记。

它不是 Codex skill，也不需要在对话里手动调用。只要脚本保持运行，它就会监听 Codex 本地 session JSONL 文件，并自动刷新 Obsidian 中对应的 Markdown 文件。

## 功能

- 自动监听 Codex 本地会话日志：`%USERPROFILE%\.codex\sessions\**\*.jsonl`
- 自动选择最近更新的会话文件
- 提取 `user` 和 `assistant` 消息
- 默认过滤 system、developer、工具调用和工具输出
- 每个 Codex session 对应一个稳定 Markdown 文件
- 会话继续更新时，覆盖刷新同一个文件
- 使用 UTF-8 with BOM 写入，兼容 Windows 和 Obsidian 中文显示

## 安装

克隆仓库：

```powershell
git clone https://github.com/Zeon814/codex-obsidian-sync.git
cd codex-obsidian-sync
```

脚本只依赖 Python 标准库，不需要安装额外依赖。

## 配置 Obsidian 路径

推荐设置环境变量：

```powershell
[Environment]::SetEnvironmentVariable("OBSIDIAN_VAULT", "D:\Documents\Obsidian Vault", "User")
```

当前 PowerShell 窗口立即生效：

```powershell
$env:OBSIDIAN_VAULT = "D:\Documents\Obsidian Vault"
```

也可以运行时显式传入：

```powershell
python scripts\watch_codex_sessions.py --vault "D:\Documents\Obsidian Vault"
```

## 使用

### 打开可见窗口运行

如果希望启动后能看到同步器是否正在运行，推荐使用这个启动脚本：

```powershell
scripts\start_watcher_window.cmd
```

它会打开一个标题为 `Codex Obsidian Sync` 的命令行窗口，并在窗口里持续运行 watcher。窗口还开着就表示脚本还在运行；关闭这个窗口后同步停止。

也可以继续传入原脚本参数：

```powershell
scripts\start_watcher_window.cmd --vault "D:\Documents\Obsidian Vault" --interval 5
```

双击 `scripts\start_watcher_window.cmd` 也可以启动。

### 直接在当前窗口运行

持续同步最近的 Codex 会话：

```powershell
python scripts\watch_codex_sessions.py
```

保持这个 PowerShell 窗口打开。你继续和 Codex 聊天时，脚本会自动更新 Obsidian 笔记。

只同步一次，用于测试：

```powershell
python scripts\watch_codex_sessions.py --once
```

指定某个 Codex 会话文件：

```powershell
python scripts\watch_codex_sessions.py --session-file "C:\Users\Administrator\.codex\sessions\2026\05\18\rollout-xxx.jsonl"
```

调整轮询间隔：

```powershell
python scripts\watch_codex_sessions.py --interval 5
```

包含 Codex 启动时的 AGENTS/environment bootstrap 消息：

```powershell
python scripts\watch_codex_sessions.py --include-bootstrap
```

## 输出路径

默认输出到：

```text
<OBSIDIAN_VAULT>\codex\YYYY-MM-DD\<对话标题> [session-id].md
```

例如：

```text
D:\Documents\Obsidian Vault\codex\2026-05-18\创建 Obsidian 同步器 [019e38ee].md
```

文件名带短 session id，因此同一段 Codex 对话会稳定覆盖同一个 Markdown 文件。

## 注意事项

- 这是外部 watcher，不是 Codex 内置后台功能。
- 脚本运行时才会同步；关闭 PowerShell 窗口后同步停止。
- Codex 如果未来修改 session JSONL 格式，脚本可能需要更新。
- 当前脚本默认过滤工具输出，避免 Obsidian 笔记被大量命令日志淹没。

## 许可证

当前仓库暂未添加许可证。
