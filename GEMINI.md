# Gemini Context: Miyabi MCP Bundle

**重要**: このプロジェクトは、172以上のツールを提供する、エコシステム内で最も包括的な MCP サーバーです。

## 1. プロジェクト概要
- **名称**: Miyabi MCP Bundle
- **役割**: Claude Desktop や AI エージェント（Miyabi Code 等）に、システム操作、Git、Docker、GitHub などの強力な能力を提供。
- **規模**: 172 Tools, 38 Agents, 22 Skills, 56 Commands。

## 2. 主要ツールカテゴリ
| カテゴリ | ツール数 | 内容 |
|:---------|:--------:|:-----|
| **Git Inspector** | 19 | ステータス、差分、履歴、タグ、貢献者 |
| **Tmux Monitor** | 10 | セッション・ペイン管理、キャプチャ |
| **Resource Monitor** | 10 | CPU, メモリ, ディスク, 温度 |
| **GitHub Integration** | 21 | Issue, PR, レビュー, リリース |
| **Docker / K8s** | 16+ | コンテナ、Compose、Pod管理 |
| **Spec-Kit** | 9 | Spec-Driven Development 支援 |
| **Database** | 6 | SQLite/PostgreSQL/MySQL (参照系) |

## 3. 主要コマンド

```bash
# 開発 (Hot Reload)
npm run dev

# ビルド
npm run build

# ヘルスチェック (診断)
miyabi-mcp doctor

# 初期設定
miyabi-mcp init
```

## 4. 開発・追加のルール
- **セキュリティ**: 全てのシェル引数は `sanitizeShellArg` でサニタイズすること。パストラバーサル防止を徹底する。
- **言語**: 日本語 (Japanese)。ツールの説明も日本語を基本とする。
- **構造**: `src/index.ts` がルーターとなり、各カテゴリのハンドラーへ振り分ける構成。

## 5. テスト
```bash
npm test            # Vitestによるユニットテスト
```

新しいツールの追加や既存ツールのバグ修正を行う際は、このコンテキストと既存のサニタイズ処理を参考にしてください。
