# リードマグネット: Miyabi完全活用ガイド（PDF）

---

## PDF仕様

| 項目 | 内容 |
|------|------|
| **タイトル** | Miyabi完全活用ガイド - 38 AIエージェントでClaude Codeを最強チームに |
| **ページ数** | 約50ページ |
| **フォーマット** | PDF (A4) |
| **デザイン** | シンプル・モダン・読みやすさ重視 |

---

## 目次構成

### 表紙
- タイトル
- サブタイトル: 「5分でセットアップ、すぐに使える完全ガイド」
- 著者名: 林俊介 / Shunsuke Hayashi
- バージョン: v2.1.0

### 第1章: はじめに（3ページ）

1.1 このガイドについて
1.2 Miyabi Pluginsとは
1.3 何ができるようになるか
1.4 対象読者

### 第2章: 5分セットアップ（5ページ）

2.1 前提条件
  - Claude Code CLI
  - Node.js 18+
  - GitHub Token（オプション）

2.2 インストール手順
  - Step 1: マーケットプレイス追加
  - Step 2: プラグインインストール
  - Step 3: 動作確認

2.3 トラブルシューティング
  - よくあるエラーと解決法

### 第3章: 38エージェント完全解説（15ページ）

3.1 エージェントとは

3.2 Codingエージェント（9種）
| エージェント | 役割 | トリガーワード |
|-------------|------|---------------|
| CoordinatorAgent | タスク統括 | coordinate, orchestrate |
| CodeGenAgent | コード生成 | generate, implement |
| ReviewAgent | コードレビュー | review, check |
| PRAgent | PR管理 | PR, pull request |
| DeploymentAgent | デプロイ | deploy, release |
| IssueAgent | Issue管理 | issue, track |
| RefresherAgent | コンテキスト更新 | refresh |
| BatchIssueAgent | バッチ処理 | batch |
| AWSAgent | AWS操作 | AWS, cloud |

3.3 Businessエージェント（16種）
- MarketingAgent
- SalesAgent
- CRMAgent
- YouTubeAgent
- AnalyticsAgent
- ContentCreationAgent
- FunnelDesignAgent
- PersonaAgent
- SNSStrategyAgent
- その他7種

3.4 特殊エージェント
- GuardianAgent（障害対応）
- HonokaAgent（コース作成）
- TmuxControlAgent（tmux制御）

3.5 エージェントの呼び出し方
- 自然言語での呼び出し
- 明示的な指定

### 第4章: 56コマンドリファレンス（10ページ）

4.1 コマンドの基本

4.2 開発系コマンド
```
/miyabi-full:pr-create
/miyabi-full:review
/miyabi-full:deploy
/miyabi-full:issue-create
/miyabi-full:codegen-execute
```

4.3 Git系コマンド
```
/miyabi-full:worktree-create
/miyabi-full:worktree-list
/miyabi-full:worktree-cleanup
```

4.4 監視系コマンド
```
/miyabi-full:dashboard
/miyabi-full:health-check
/miyabi-full:logs
/miyabi-full:quality-score
```

4.5 自動化系コマンド
```
/miyabi-full:agent-run
/miyabi-full:parallel-execute
/miyabi-full:tmux-control
```

4.6 全コマンド一覧表

### 第5章: 25スキル活用法（5ページ）

5.1 スキルとは

5.2 開発スキル
- rust-development
- tdd-workflow
- git-workflow
- debugging-troubleshooting

5.3 品質スキル
- security-audit
- performance-analysis
- documentation-generation

5.4 ビジネススキル
- business-strategy-planning
- market-research-analysis
- content-marketing-strategy

5.5 スキルの発動方法

### 第6章: マルチエージェント連携（7ページ）

6.1 連携の仕組み

6.2 基本パターン: Issue解決フロー
```
User → Coordinator → CodeGen → Review → PR → Deploy
```

6.3 応用パターン: 新機能開発フロー

6.4 高度なパターン: 並列処理

6.5 tmuxを使った連携（上級）

### 第7章: カスタマイズ（5ページ）

7.1 エージェントのカスタマイズ
- 指示の変更
- 新規エージェント作成

7.2 コマンドの追加
- コマンドファイルの作成
- 引数の定義

7.3 独自スキルの作成
- SKILL.mdの構造
- トリガーワードの設定

7.4 hooksのカスタマイズ
- Pre/PostToolUse
- SessionStart/End

### 付録A: MCP統合（3ページ）

A.1 miyabi-mcp-bundleとは
A.2 172ツールカテゴリ一覧
A.3 MCPサーバー設定

### 付録B: トラブルシューティング（3ページ）

B.1 インストール関連
B.2 接続関連
B.3 コマンド関連
B.4 GitHub関連

### 付録C: リソース（1ページ）

- GitHub リポジトリ
- npm パッケージ
- Discord コミュニティ
- お問い合わせ先

### 奥付

- 著者プロフィール
- 更新履歴
- ライセンス（Apache 2.0）
- LINE公式アカウント再案内

---

## デザインガイドライン

### カラーパレット

| 用途 | カラー | HEX |
|------|--------|-----|
| メイン | 藍色（Miyabiブランド） | #1E3A5F |
| アクセント | 桜色 | #FFB7C5 |
| 背景 | オフホワイト | #FAFAFA |
| テキスト | ダークグレー | #333333 |
| コード背景 | ライトグレー | #F5F5F5 |

### フォント

- 見出し: Noto Sans JP Bold
- 本文: Noto Sans JP Regular
- コード: Source Code Pro

### レイアウト

- 余白: 十分に取る
- 1ページあたりの情報量: 控えめに
- 図表: 積極的に使用
- コードブロック: 背景色付き

---

## 制作ツール

### 推奨ツール

| ツール | 用途 |
|--------|------|
| **Notion** | 原稿作成 → PDF出力 |
| **Canva** | デザイン・表紙作成 |
| **Figma** | 図表・ダイアグラム |
| **Google Docs** | 原稿作成 |

### 代替ツール

- Adobe InDesign（高品質）
- Affinity Publisher
- Pages（Mac）

---

## 配布方法

### ホスティング

| 方法 | メリット | デメリット |
|------|---------|-----------|
| **Google Drive** | 無料、簡単 | ダウンロード追跡が弱い |
| **Notion** | 直接閲覧可能 | PDF DL手間 |
| **Gumroad** | DL追跡、メール取得 | 設定が必要 |
| **ConvertKit** | メール連携 | 有料 |

### 推奨

1. **LINE登録 → 自動返信でリンク送付**
2. Google Drive または Gumroad でホスティング
3. Bitly短縮URLで追跡

---

## 更新計画

### バージョニング

- v1.0.0: 初版公開
- v1.1.0: フィードバック反映
- v2.0.0: 大幅更新時

### 更新タイミング

- Miyabi Plugins メジャーアップデート時
- 新エージェント追加時
- ユーザーフィードバックに基づく改善
