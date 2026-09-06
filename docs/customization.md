# カスタマイズガイド

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

## CONTRIBUTINGガイドの変更

`CONTRIBUTING.md` を編集して、プロジェクト固有のコントリビューションルールを追加できます。

## LICENSEの変更

別のライセンスを使用する場合は、`LICENSE` ファイルを適切なライセンステキストに置き換えてください。

主なライセンステンプレート：
- [MIT License](https://opensource.org/licenses/MIT)
- [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [GPL v3](https://www.gnu.org/licenses/gpl-3.0.en.html)
