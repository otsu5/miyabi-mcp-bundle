# MCP Resources/List と Resources/Templates/List の仕様

## 目的
- MCPクライアントから `resources/list` と `resources/templates/list` が呼ばれた際に、正しい応答を返す。
- リソース探索とテンプレート探索の入口を提供する。

## 背景
- 現状 `resources/list` / `resources/templates/list` が `Method not found` となるケースがある。
- MCP SDKは `resources/templates/list` を標準メソッドとして定義している。

## 期待動作
### resources/list
- `resources` 配列を返す。
- 配列の要素は `uri`, `name` を必須とし、`description`, `mimeType` を含む。
- 現行の `resources` 定義に一致する内容を返す。

### resources/templates/list
- `resourceTemplates` 配列を返す。
- 動的なテンプレートが未定義の場合は空配列を返す。
- 将来の拡張に備え `name`, `uriTemplate`, `description`, `mimeType` をサポートする。

## トリガー条件（発動文脈）
- MCPクライアントがリソース一覧を必要とするとき
  - 例: リソース探索、利用可能なURIの提示
- MCPクライアントがテンプレート化されたURIを必要とするとき
  - 例: 動的URIの提示（将来対応）

## 例
### resources/list 応答例（抜粋）
```json
{
  "resources": [
    {
      "uri": "miyabi://git/status",
      "name": "Git Repository Status",
      "description": "Current git repository status including branch, staged changes, and modified files",
      "mimeType": "application/json"
    }
  ]
}
```

### resources/templates/list 応答例
```json
{
  "resourceTemplates": []
}
```

## 非目標
- 個別リソースの内容自体の変更（ReadResourceの挙動）
- 既存のtools/promptの仕様変更
