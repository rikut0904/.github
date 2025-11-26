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

## ワークフロー関連

### ワークフローで403エラーが発生

**エラーメッセージ:**
```
HTTP 403: Resource not accessible by integration
```

**原因:**
- GitHub Appの権限不足
- シークレットの設定ミス
- GitHub Appがインストールされていない

**解決方法:**

1. **GitHub Appの権限を確認**
   - GitHub App設定で **Repository permissions → Issues: Read and write** が付与されているか確認
   - 権限を変更した場合は、再インストールが必要な場合があります

2. **シークレットが正しく登録されているか確認**
   - リポジトリ → Settings → Secrets and variables → Actions
   - `APP_ID` と `APP_PRIVATE_KEY` が存在するか確認
   - 値に余分なスペースや改行が含まれていないか確認

3. **GitHub Appがリポジトリにインストールされているか確認**
   - GitHub App設定 → Install App
   - 対象のリポジトリにアクセス権があるか確認

4. **permissions設定を確認**
   - ワークフローファイルに以下が含まれているか確認：
   ```yaml
   permissions:
     issues: write
     contents: read
   ```

### ワークフローが実行されない

**解決方法:**

1. **トリガー条件を確認**
   - `on: push: branches: - main` となっているか確認
   - pushしたブランチ名が一致しているか確認

2. **ワークフローファイルの配置場所を確認**
   - `.github/workflows/` に配置されているか確認（`workflows/` ではない）

3. **YAMLの構文エラーを確認**
   - Actions タブでエラーメッセージを確認

4. **ワークフローが無効化されていないか確認**
   - Actions タブでワークフローが有効になっているか確認

### トークン生成エラー

**エラーメッセージ:**
```
Error: Input required and not supplied: app-id
```

**解決方法:**
- `APP_ID` シークレットが正しく登録されているか確認
- シークレット名のスペルミスがないか確認（大文字小文字を区別）

## スクリプト関連

### "Permission denied" エラー

**エラーメッセージ:**
```bash
-bash: ./scripts/create-labels.sh: Permission denied
```

**解決方法:**
```bash
chmod +x scripts/create-labels.sh
```

### "cannot execute: required file not found" エラー

**原因:**
- 改行コードがCRLF（Windows形式）になっている
- shebangのパスが間違っている

**解決方法:**

1. **改行コードをLF（Unix形式）に変換**
   ```bash
   sed -i 's/\r$//' scripts/create-labels.sh
   ```

2. **または `dos2unix` コマンドを使用**
   ```bash
   dos2unix scripts/create-labels.sh
   ```

### GitHub CLI認証エラー

**エラーメッセージ:**
```
error: authentication required
```

**解決方法:**
```bash
gh auth login
```
プロンプトに従って認証を完了してください。

### リポジトリが見つからない

**エラーメッセージ:**
```
リポジトリが見つかりませんでした
```

**解決方法:**

1. **GitHub CLIが正しく認証されているか確認**
   ```bash
   gh auth status
   ```

2. **リポジトリへのアクセス権があるか確認**
   - オーナー名が正しいか確認
   - リポジトリがprivateの場合、アクセス権があるか確認

## ラベル関連

### ラベルが作成されない

**解決方法:**

1. **ワークフローが正常に完了しているか確認**
   - Actions タブでワークフローの実行結果を確認
   - エラーメッセージがあれば対応

2. **ラベルの定義を確認**
   - フォーマットが `"name|color|description"` になっているか確認
   - 色コードが6桁の16進数（`#` なし）になっているか確認

3. **既存ラベルとの競合**
   - 同名のラベルが既に存在する場合、エラーが発生する可能性があります
   - ワークフローでは既存ラベルを削除してから作成しているため、通常は問題ありません

### Issueテンプレートとラベルが一致しない

**症状:**
- Issueテンプレートで指定したラベルが存在しない

**解決方法:**
- Issueテンプレートの `labels:` で指定しているラベル名と、ワークフロー/スクリプトで作成するラベル名が一致しているか確認
- 例: テンプレートで `labels: ["documentation"]` だが、実際のラベルは `docs`

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
