# Miyabi Plugins 画像仕様書

## 1. サムネイル画像（note.com用）

### 仕様
- **サイズ**: 1280 x 670 px（16:9）
- **フォーマット**: PNG/JPG
- **ファイル名**: `thumbnail-miyabi-plugins.png`

### デザイン要素
- **背景**: ダークブルー/パープルのグラデーション（#1E3A5F → #4A1E6F）
- **メインテキスト**: 「38 AI Agents」大きく中央に
- **サブテキスト**: 「for Claude Code」
- **ブランド名**: 「Miyabi Plugins」ロゴ風
- **装飾**: 抽象的なAI/ニューラルネットワークのイメージ
- **バッジ**: 「無料」「Open Source」

### 画像生成プロンプト（Gemini/DALL-E用）

```
Create a modern, professional thumbnail image for a tech article.

Design specifications:
- Size: 1280x670 pixels (16:9 ratio)
- Background: Dark gradient from deep blue (#1E3A5F) to purple (#4A1E6F)
- Style: Modern, tech, futuristic, clean

Main elements:
- Large text "38 AI Agents" in white, bold, centered
- Subtitle "for Claude Code" below in lighter weight
- Brand name "Miyabi Plugins" at bottom with elegant styling
- Abstract neural network / AI circuit patterns in the background (subtle, not overwhelming)
- Small badges: "FREE" and "Open Source" in the corner

Visual style:
- Minimalist but impactful
- High contrast for readability
- Professional tech aesthetic
- Japanese-inspired subtle elegance (Miyabi = elegance in Japanese)
```

---

## 2. エージェント紹介画像（5種類）

### 共通仕様
- **サイズ**: 800 x 600 px
- **フォーマット**: PNG
- **スタイル**: キャラクターイラスト + 説明テキスト

### 2.1 CoordinatorAgent（しきるん）

**ファイル名**: `agent-coordinator-shikirun.png`

**キャラクター設定**:
- 指揮者のようなポーズ
- 紫/藍色のテーマカラー
- 🎭 マスクアイコン

**プロンプト**:
```
Create a character illustration for an AI agent named "Shikirun" (しきるん).

Character:
- Role: Coordinator/Conductor agent
- Personality: Leadership, organized, reliable
- Visual style: Anime-inspired professional character
- Color theme: Purple and indigo (#663399)
- Props: Conductor's baton or clipboard
- Expression: Confident, friendly smile
- Icon element: Theater mask emoji 🎭

Layout:
- Character on left side (60%)
- Right side: Agent name "CoordinatorAgent" and Japanese name "しきるん"
- Role description: "タスク統括・チーム指揮"
- Background: Soft gradient, clean
```

### 2.2 CodeGenAgent（カエデ）

**ファイル名**: `agent-codegen-kaede.png`

**キャラクター設定**:
- コーディングのポーズ
- オレンジ/赤のテーマカラー（紅葉）
- 🍁 もみじアイコン

**プロンプト**:
```
Create a character illustration for an AI agent named "Kaede" (カエデ).

Character:
- Role: Code Generation agent
- Personality: Creative, precise, efficient
- Visual style: Anime-inspired developer character
- Color theme: Orange and red like autumn leaves (#FF6B35)
- Props: Laptop or floating code snippets
- Expression: Focused, creative
- Icon element: Maple leaf emoji 🍁

Layout:
- Character on left side (60%)
- Right side: Agent name "CodeGenAgent" and Japanese name "カエデ"
- Role description: "コード生成・実装"
- Background: Code-like pattern, subtle
```

### 2.3 ReviewAgent（サクラ）

**ファイル名**: `agent-review-sakura.png`

**キャラクター設定**:
- 検査/確認のポーズ
- ピンク/桜色のテーマカラー
- 🌸 桜アイコン

**プロンプト**:
```
Create a character illustration for an AI agent named "Sakura" (サクラ).

Character:
- Role: Code Review agent
- Personality: Meticulous, quality-focused, supportive
- Visual style: Anime-inspired QA character
- Color theme: Pink, cherry blossom (#FFB7C5)
- Props: Magnifying glass or checklist
- Expression: Thoughtful, detail-oriented
- Icon element: Cherry blossom emoji 🌸

Layout:
- Character on left side (60%)
- Right side: Agent name "ReviewAgent" and Japanese name "サクラ"
- Role description: "コードレビュー・品質保証"
- Background: Soft pink gradient
```

### 2.4 PRAgent（ツバキ）

**ファイル名**: `agent-pr-tsubaki.png`

**キャラクター設定**:
- マージ/統合のポーズ
- 赤/深紅のテーマカラー（椿）
- 🌺 花アイコン

**プロンプト**:
```
Create a character illustration for an AI agent named "Tsubaki" (ツバキ).

Character:
- Role: Pull Request Management agent
- Personality: Diplomatic, organized, collaborative
- Visual style: Anime-inspired project manager character
- Color theme: Deep red, camellia flower (#DC143C)
- Props: Git branch diagram or merge icon
- Expression: Welcoming, professional
- Icon element: Hibiscus emoji 🌺

Layout:
- Character on left side (60%)
- Right side: Agent name "PRAgent" and Japanese name "ツバキ"
- Role description: "プルリクエスト管理"
- Background: Branch-like patterns
```

### 2.5 DeploymentAgent（ボタン）

**ファイル名**: `agent-deployment-botan.png`

**キャラクター設定**:
- ロケット打ち上げのポーズ
- 黄色/ゴールドのテーマカラー（牡丹）
- 🌼 花アイコン

**プロンプト**:
```
Create a character illustration for an AI agent named "Botan" (ボタン).

Character:
- Role: Deployment agent
- Personality: Bold, reliable, action-oriented
- Visual style: Anime-inspired DevOps character
- Color theme: Yellow, gold, peony flower (#FFD700)
- Props: Rocket or deploy button
- Expression: Confident, ready for action
- Icon element: Blossom emoji 🌼

Layout:
- Character on left side (60%)
- Right side: Agent name "DeploymentAgent" and Japanese name "ボタン"
- Role description: "デプロイ・リリース管理"
- Background: Cloud/server patterns
```

---

## 3. インストール手順図解

### 仕様
- **サイズ**: 1200 x 800 px
- **フォーマット**: PNG
- **ファイル名**: `installation-steps.png`

### デザイン要素

```
┌─────────────────────────────────────────────────────────────┐
│                   5分でセットアップ完了                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────┐     ┌─────────┐     ┌─────────┐             │
│   │  STEP   │     │  STEP   │     │  STEP   │             │
│   │   1     │ ─→  │   2     │ ─→  │   3     │             │
│   │         │     │         │     │         │             │
│   │ 📦      │     │ 🔧      │     │ ✓       │             │
│   │         │     │         │     │         │             │
│   │Marketplace│   │ Install │     │ Verify  │             │
│   │  追加    │     │ プラグイン│     │ 確認    │             │
│   └─────────┘     └─────────┘     └─────────┘             │
│                                                             │
│   /plugin marketplace add    /plugin install      /plugin list │
│   ShunsukeHayashi/...       miyabi-full@...                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### プロンプト

```
Create a step-by-step installation guide infographic.

Design:
- Size: 1200x800 pixels
- Style: Clean, modern, minimal
- Color scheme: Blue gradient background, white cards

Content:
3 horizontal steps connected by arrows

Step 1: "Marketplace追加"
- Icon: Package emoji 📦
- Command: /plugin marketplace add ShunsukeHayashi/miyabi-claude-plugins

Step 2: "プラグインインストール"
- Icon: Tool emoji 🔧
- Command: /plugin install miyabi-full@miyabi-plugins

Step 3: "確認"
- Icon: Checkmark ✓
- Command: /plugin list
- Result: "✓ miyabi-full (v2.1.0)"

Header: "5分でセットアップ完了" in large text
Footer: "これだけで38個のAIエージェントが使えます！"
```

---

## 4. フロー図（Issue解決自動化）

### 仕様
- **サイズ**: 1200 x 600 px
- **フォーマット**: PNG
- **ファイル名**: `flow-issue-resolution.png`

### デザイン

```
┌──────────────────────────────────────────────────────────────┐
│                  Issue解決の自動化フロー                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  👤 User                                                     │
│    │                                                         │
│    ▼ "Issue #123を解決して"                                   │
│                                                              │
│  🎭 Coordinator ─→ 🍁 CodeGen ─→ 🌸 Review ─→ 🌺 PR         │
│    │ 分析           │ 修正       │ レビュー    │ PR作成      │
│    │                │            │            │             │
│    └────────────────┴────────────┴────────────┴─────────→   │
│                                                              │
│  ✅ 完了: Issue #123 は PR #456 で修正されます                 │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 5. LINE登録バナー

### 仕様
- **サイズ**: 1200 x 400 px
- **フォーマット**: PNG
- **ファイル名**: `line-registration-banner.png`

### デザイン要素
- LINEグリーン（#06C755）をアクセントに
- 特典3つをアイコンで表示
- CTAボタン: 「LINE登録はこちら」

### プロンプト

```
Create a LINE registration banner for the Miyabi Plugins article.

Design:
- Size: 1200x400 pixels
- Background: White with LINE green (#06C755) accents
- Style: Clean, friendly, inviting

Content:
- Header: "LINE公式アカウント登録で特典プレゼント 🎁"
- 3 benefit icons in a row:
  1. 📚 PDF完全ガイド
  2. 🎬 動画チュートリアル
  3. 💬 限定コミュニティ
- CTA button: "LINE登録はこちら →" in LINE green
- QR code placeholder area
```

---

## 生成ツール推奨

| ツール | 用途 | 推奨度 |
|--------|------|--------|
| **Canva** | 全画像（テンプレート豊富） | ⭐⭐⭐⭐⭐ |
| **Figma** | カスタムデザイン | ⭐⭐⭐⭐ |
| **DALL-E 3** | キャラクターイラスト | ⭐⭐⭐⭐ |
| **Midjourney** | 高品質イラスト | ⭐⭐⭐⭐⭐ |
| **Gemini Imagen** | 多目的 | ⭐⭐⭐ |

---

## ファイル一覧

```
marketing/images/
├── image-specs.md              # この仕様書
├── thumbnail-miyabi-plugins.png
├── agent-coordinator-shikirun.png
├── agent-codegen-kaede.png
├── agent-review-sakura.png
├── agent-pr-tsubaki.png
├── agent-deployment-botan.png
├── installation-steps.png
├── flow-issue-resolution.png
└── line-registration-banner.png
```

合計: **9枚の画像**
