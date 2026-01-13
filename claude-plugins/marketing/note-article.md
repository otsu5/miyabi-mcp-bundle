# note.com 記事ドラフト

---

## タイトル案

**メイン案:**
> 【無料公開】Claude Codeを"自律型AI開発チーム"に変える「Miyabi Plugins」- 25+エージェント、50+コマンドを完全解説

**サブ案:**
> エンジニア必見！Claude Codeに38個のAIエージェントを追加して開発効率10倍にする方法

---

## 記事本文

---

# 【無料公開】Claude Codeを"自律型AI開発チーム"に変える「Miyabi Plugins」

こんにちは、林俊介（[@ShunsukeHayashi](https://github.com/ShunsukeHayashi)）です。

今日は、私が開発した**Claude Code用プラグイン「Miyabi Plugins」**を完全無料で公開します。

## この記事で得られること

- Claude Codeを**25+のAIエージェントが協調する開発チーム**に変える方法
- コード生成、レビュー、PR作成、デプロイまで**自動化する具体的手順**
- **5分でセットアップ**できるインストールガイド

---

## Miyabi Pluginsとは？

Miyabi Pluginsは、Claude Code（Anthropic公式CLI）を拡張するプラグイン集です。

### 何ができるようになるのか？

| Before (素のClaude Code) | After (Miyabi導入後) |
|-------------------------|---------------------|
| 対話でコード生成 | 専門エージェントが自動で最適なコード生成 |
| 手動でGitHub操作 | `/pr-create` で一発PR作成 |
| コードレビューは人力 | ReviewAgentが自動レビュー |
| デプロイは手動 | DeploymentAgentが自動デプロイ |

### 数字で見るMiyabi

```
📦 8つのプラグインパッケージ
🤖 38個のAIエージェント
⚡ 56個のスラッシュコマンド
🎯 25個の専門スキル
🔧 172個のMCPツール（miyabi-mcp-bundle）
```

---

## なぜ無料で公開するのか？

正直に言います。

**AIエージェントの可能性を、より多くのエンジニアに体験してほしいから。**

私は過去1年間、AIエージェントによる自律開発を研究してきました。その結果をオープンソースとして公開することで、エンジニアコミュニティ全体のレベルアップに貢献したいと考えています。

---

## 5分でできるインストール手順

### 前提条件

- Claude Code CLI がインストール済み
- Node.js 18以上
- GitHubアカウント（GitHub連携を使う場合）

### Step 1: マーケットプレイス追加

Claude Codeを起動して、以下を入力：

```
/plugin marketplace add ShunsukeHayashi/miyabi-claude-plugins
```

### Step 2: プラグインインストール

```
/plugin install miyabi-full@miyabi-plugins
```

### Step 3: 確認

```
/plugin list
```

以下のように表示されればOK！

```
✓ miyabi-full (v2.1.0)
  Agents: 38 | Commands: 56 | Skills: 25
```

**これだけです。5分かかりません。**

---

## 主要エージェント紹介

### 1. CoordinatorAgent（しきるん）

チーム全体を統括する指揮官エージェント。

```
「このIssueを解決して」と言うだけで：
1. 問題を分析
2. 適切なエージェントにタスク分配
3. 進捗を監視
4. 完了報告
```

### 2. CodeGenAgent（カエデ）

コード生成の専門家。

```
「React用のユーザープロファイルコンポーネントを作って」
↓
・TypeScript対応
・Propsの型定義
・テストコード
・Storybook用ストーリー
まで自動生成
```

### 3. ReviewAgent（サクラ）

コードレビューの専門家。

```
・セキュリティ脆弱性チェック
・パフォーマンス問題の指摘
・コーディング規約違反の検出
・改善提案
```

### 4. PRAgent（ツバキ）

Pull Request管理の専門家。

```
/miyabi-full:pr-create
↓
・変更内容を自動要約
・レビュアー自動アサイン
・CI/CD状態監視
・マージ判断
```

### 5. DeploymentAgent（ボタン）

デプロイ自動化の専門家。

```
/miyabi-full:deploy
↓
・本番環境チェック
・デプロイ実行
・ヘルスチェック
・ロールバック対応
```

---

## 実際の使用例

### 例1: Issue解決の自動化

```
User: Issue #123 を解決して

Claude (with Miyabi):
1. [CoordinatorAgent] Issue #123 を分析中...
   → バグ: ログイン時にエラーが発生

2. [CodeGenAgent] 修正コードを生成中...
   → src/auth/login.ts を修正

3. [ReviewAgent] コードレビュー中...
   → ✓ セキュリティ問題なし
   → ✓ テスト追加済み

4. [PRAgent] PR作成中...
   → PR #456 を作成しました

5. [CoordinatorAgent] 完了報告
   → Issue #123 は PR #456 で修正されます
```

### 例2: 新機能開発

```
User: ダークモード機能を追加して

Claude (with Miyabi):
1. 要件分析 → テーマシステム設計
2. コード生成 → ThemeProvider, useTheme hook
3. スタイル更新 → 全コンポーネントのダークモード対応
4. テスト作成 → テーマ切り替えのテスト
5. PR作成 → 「feat: add dark mode support」
```

---

## 便利なコマンド一覧

### 開発系

| コマンド | 説明 |
|---------|------|
| `/miyabi-full:pr-create` | PR作成 |
| `/miyabi-full:review` | コードレビュー |
| `/miyabi-full:deploy` | デプロイ |
| `/miyabi-full:issue-create` | Issue作成 |

### 監視系

| コマンド | 説明 |
|---------|------|
| `/miyabi-full:dashboard` | プロジェクトダッシュボード |
| `/miyabi-full:health-check` | システムヘルスチェック |
| `/miyabi-full:logs` | ログ確認 |

### Git系

| コマンド | 説明 |
|---------|------|
| `/miyabi-full:worktree-create` | Git worktree作成 |
| `/miyabi-full:worktree-list` | worktree一覧 |

---

## MCP統合: 172+ツール

Miyabi PluginsはMCP（Model Context Protocol）サーバー `miyabi-mcp-bundle` と連携します。

### 利用可能なツールカテゴリ

| カテゴリ | ツール数 | 主な機能 |
|---------|---------|---------|
| GitHub | 21 | Issue/PR/Actions管理 |
| Git | 19 | バージョン管理 |
| Docker | 14 | コンテナ管理 |
| Kubernetes | 6 | K8s操作 |
| Network | 15 | ネットワーク診断 |
| Process | 14 | プロセス管理 |

---

## よくある質問

### Q: 本当に無料ですか？

**A: はい、完全無料です。** Apache 2.0ライセンスで公開しています。商用利用もOKです。

### Q: Claude Proじゃないと使えませんか？

**A: Claude Code CLIが使えれば利用可能です。** Anthropicのサブスクリプションは別途必要です。

### Q: セキュリティは大丈夫？

**A: オープンソースなので、コードを確認できます。** 機密情報はローカルに保存され、外部に送信されません。

### Q: カスタマイズできますか？

**A: できます。** エージェントの指示、コマンドの動作、すべてMarkdownファイルで定義されているので、自由に編集できます。

---

## 今後のロードマップ

- [ ] Webダッシュボード
- [ ] VS Code拡張
- [ ] チーム向け共有機能
- [ ] カスタムエージェント作成ウィザード

---

## まとめ

Miyabi Pluginsを使えば、Claude Codeが**38個のAIエージェントによる開発チーム**に変わります。

- **5分でセットアップ完了**
- **完全無料・オープンソース**
- **25+エージェント、50+コマンド**

ぜひ試してみてください！

---

## インストールコマンド（再掲）

```
/plugin marketplace add ShunsukeHayashi/miyabi-claude-plugins
/plugin install miyabi-full@miyabi-plugins
```

---

## リンク

- **GitHub**: https://github.com/ShunsukeHayashi/miyabi-claude-plugins
- **MCP Bundle (npm)**: https://www.npmjs.com/package/miyabi-mcp-bundle
- **Twitter/X**: [@ShunsukeHayashi](https://twitter.com/ShunsukeHayashi)

---

## LINE公式アカウント登録で特典

**LINE公式アカウントに登録いただくと、以下の特典をお届けします：**

🎁 **登録特典**
1. **Miyabi完全活用ガイド（PDF）** - 全エージェント・コマンドの詳細解説
2. **動画チュートリアル** - セットアップから実践まで
3. **限定コミュニティ招待** - 質問し放題

📱 **LINE登録はこちら**
👉 [LINE公式アカウント登録](https://lin.ee/xxxxx)

---

## いいね・フォローお願いします！

この記事が役に立ったら、ぜひ「スキ」と「フォロー」をお願いします！

最新のAI開発情報を発信していきます。

---

**Author**: 林俊介 / Shunsuke Hayashi
**Published**: 2026年1月

#Claude #AI開発 #プログラミング #エンジニア #自動化 #GitHub #オープンソース

---

## 記事メタデータ（note.com設定用）

- **カテゴリ**: テクノロジー
- **タグ**: Claude, AI開発, プログラミング, エンジニア, 自動化, GitHub, オープンソース, AIエージェント, 無料
- **サムネイル**: Miyabiロゴ + 「38 AI Agents」テキスト
- **有料/無料**: 無料公開
