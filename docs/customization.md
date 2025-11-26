# カスタマイズガイド

## ラベルの追加・変更

### 変更するファイル

ラベルをカスタマイズする場合、以下の2つのファイルを編集してください：

1. `workflows/setup-labels.yml` - ワークフロー用
2. `scripts/create-labels.sh` - 手動スクリプト用

### 編集方法

#### 1. workflows/setup-labels.yml

```yaml
- name: Create labels
  run: |
    labels=(
      "bug|d73a4a|バグ報告"
      "feature|a2eeef|新機能追加"
      "docs|0075ca|ドキュメント改善"
      "refactor|fbca04|リファクタリング"
      "other|5319e7|その他"
      "custom|00ff00|カスタムラベル"  # 追加例
    )
```

#### 2. scripts/create-labels.sh

```bash
labels=(
  "bug|d73a4a|バグ報告"
  "feature|a2eeef|新機能追加"
  "docs|0075ca|ドキュメント改善"
  "refactor|fbca04|リファクタリング"
  "other|5319e7|その他"
  "custom|00ff00|カスタムラベル"  # 追加例
)
```

### フォーマット

```
"ラベル名|色コード|説明"
```

- **ラベル名**: GitHub上で表示される名前（英数字推奨）
- **色コード**: 6桁の16進数カラーコード（`#` なし）
- **説明**: ラベルの説明文（日本語可）

### 色コード例

| 色 | コード | 用途例 |
|----|--------|--------|
| 🔴 赤 | `d73a4a` | バグ、重要 |
| 🟠 オレンジ | `d93f0b` | 警告 |
| 🟡 黄 | `fbca04` | リファクタリング |
| 🟢 緑 | `0e8a16` | 完了、承認 |
| 🔵 青 | `0075ca` | ドキュメント |
| 🔵 水色 | `a2eeef` | 機能追加 |
| 🟣 紫 | `5319e7` | その他 |
| ⚫ グレー | `6e7681` | 無効、重複 |

## Issueテンプレートの追加

### 新しいテンプレートの作成

`.github/ISSUE_TEMPLATE/` に新しいYAMLファイルを作成します。

**例: `security.yml`（セキュリティ報告）**

```yaml
name: セキュリティ報告テンプレート
description: セキュリティの脆弱性報告はこちらから
labels: ["security"]
body:
  - type: textarea
    id: vulnerability
    attributes:
      label: 脆弱性の概要
      placeholder: 脆弱性の内容を説明してください
    validations:
      required: true

  - type: textarea
    id: impact
    attributes:
      label: 影響範囲
      placeholder: この脆弱性による影響を説明してください
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: 再現手順
      placeholder: |
        1.
        2.
        3.
    validations:
      required: false
```

### テンプレートの構文

詳細は [GitHub公式ドキュメント](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms) を参照してください。

### 既存テンプレートの編集

`.github/ISSUE_TEMPLATE/` 内の既存ファイルを直接編集できます。

## Pull Requestテンプレートの変更

`PULL_REQUEST_TEMPLATE.md` を編集することで、PRテンプレートをカスタマイズできます。

## ワークフローのカスタマイズ

### トリガーの変更

デフォルトでは `main` ブランチへのpush時に実行されますが、変更可能です：

```yaml
on:
  push:
    branches:
      - main
      - master  # 追加
  workflow_dispatch:  # 手動実行を許可
```

### 実行条件の追加

特定の条件でのみ実行するように変更できます：

```yaml
on:
  push:
    branches:
      - main
    paths:
      - '.github/workflows/setup-labels.yml'  # このファイルが変更された時のみ
```

## CONTRIBUTINGガイドの変更

`CONTRIBUTING.md` を編集して、プロジェクト固有のコントリビューションルールを追加できます。

## LICENSEの変更

別のライセンスを使用する場合は、`LICENSE` ファイルを適切なライセンステキストに置き換えてください。

主なライセンステンプレート：
- [MIT License](https://opensource.org/licenses/MIT)
- [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [GPL v3](https://www.gnu.org/licenses/gpl-3.0.en.html)
