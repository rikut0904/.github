# トラブルシューティング

## Issueテンプレート関連

### Issueテンプレートが表示されない

**症状:**
- Issue作成時にテンプレート選択画面が表示されない
- テンプレートが認識されない

**解決方法:**

1. **リポジトリの公開設定を確認**
   - `.github` リポジトリが **public** であることを確認
   - Private の場合、他のリポジトリから参照できません

2. **ファイルの配置場所を確認**
   - テンプレートが `.github/ISSUE_TEMPLATE/` に配置されているか確認
   - ディレクトリ名のスペルミスがないか確認（大文字小文字も区別されます）

3. **YAMLの構文エラーを確認**
   - [YAML Validator](https://www.yamllint.com/) でテンプレートファイルを検証
   - インデントがスペース2つで統一されているか確認
   - 引用符やコロンの使い方が正しいか確認

4. **ブラウザのキャッシュをクリア**
   - ブラウザのキャッシュが原因の場合があります
   - シークレットモードで試してみる

5. **GitHubに変更が反映されるまで待つ**
   - pushしてから数分待ってから再度確認

## その他

### 変更が反映されない

**解決方法:**

1. **Git pushを確認**
   ```bash
   git status
   git log -1
   ```

2. **GitHub上で変更が反映されているか確認**
   - GitHubのリポジトリページでファイルの内容を確認

3. **ブラウザキャッシュをクリア**
   - Ctrl+Shift+R（Windows/Linux）
   - Cmd+Shift+R（Mac）

### さらにサポートが必要な場合

- [GitHub Community](https://github.community/)
- [GitHub Actions ドキュメント](https://docs.github.com/en/actions)
- [GitHub CLI ドキュメント](https://cli.github.com/manual/)

問題が解決しない場合は、Issueを作成して詳細を報告してください。
