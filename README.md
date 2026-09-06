# .github リポジトリ

このリポジトリは、全リポジトリに共通のGitHub設定を管理する特殊リポジトリです。

## 概要

このリポジトリには以下が含まれています：

- **Issueテンプレート**: バグ報告、機能追加、ドキュメント改善、リファクタリング、その他
- **Pull Requestテンプレート**: PRの標準フォーマット

## ディレクトリ構成

```
.github/
├── ISSUE_TEMPLATE/          # Issueテンプレート（全リポジトリで利用可能）
│   ├── bug.yml              # バグ報告
│   ├── feature.yml          # 機能追加
│   ├── documentation.yml    # ドキュメント改善
│   ├── refactor.yml         # リファクタリング
│   ├── performance.yml      # その他（ビルド・設定変更）
│   └── config.yml           # テンプレート設定
├── PULL_REQUEST_TEMPLATE.md # PRテンプレート（全リポジトリで利用可能）
├── docs/                    # ドキュメント
│   ├── customization.md     # カスタマイズガイド
│   └── troubleshooting.md   # トラブルシューティング
├── CONTRIBUTING.md          # コントリビューションガイド
├── LICENSE                  # MITライセンス
└── README.md                # このリポジトリの説明
```

## 使い方

### 1. Issueテンプレートの利用

このリポジトリが存在することで、organizationまたはアカウント配下の全リポジトリで自動的にIssueテンプレートが利用可能になります。

新しいIssueを作成する際、以下のテンプレートから選択できます：
- バグ報告
- 機能追加
- ドキュメント改善
- リファクタリング
- その他

### 2. Pull Requestテンプレート

PRを作成すると、自動的にテンプレートが適用されます。

## ドキュメント

- [カスタマイズガイド](./docs/customization.md) - テンプレートのカスタマイズ方法
- [トラブルシューティング](./docs/troubleshooting.md) - よくある問題と解決方法

## コントリビューション

コントリビューションを歓迎します！[コントリビューションガイド](./CONTRIBUTING.md)を参照してください。

## ライセンス

このプロジェクトは [MIT License](./LICENSE) の下で公開されています。

## 参考資料

- [GitHub Issue templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/about-issue-and-pull-request-templates)
