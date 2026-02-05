---
name: resource-discovery
description: MCPのリソース一覧とテンプレート一覧を取得し、利用可能なURIを提示・案内する。
allowed-tools: Read
mcp_resources:
  - "resources/list"
  - "resources/templates/list"
  - "resources/read"
---

# Resource Discovery Skill

**バージョン**: 1.0.0
**目的**: MCPリソース探索とURI案内

---

## トリガー

| トリガー | 例 |
|---------|-----|
| リソース一覧 | "リソース一覧", "resources/list", "使えるURIを教えて" |
| テンプレート一覧 | "テンプレート一覧", "resources/templates/list" |
| URI参照 | "miyabi://", "resource read" |

---

## 手順

### 1) リソース一覧
- `resources/list` を呼び、利用可能なURIを列挙する。

### 2) テンプレート一覧
- `resources/templates/list` を呼び、テンプレートURIがあれば提示する。
- 未定義の場合は空配列であることを明示する。

### 3) 個別リソース参照
- ユーザー指定のURIがあれば `resources/read` で取得し、要点を日本語で要約する。

---

## 出力ルール
- 日本語で簡潔に報告する。
- URIはそのまま提示する。
- 取得日を明記する（例: 2026-02-06）。
