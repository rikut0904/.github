# セットアップガイド

## GitHub Appの設定

### 1. GitHub Appの作成

1. GitHub → Settings → Developer settings → GitHub Apps → **New GitHub App**
2. 基本情報を入力：
   - **GitHub App name**: 任意の名前
   - **Homepage URL**: リポジトリのURL
   - **Webhook**: 不要な場合はチェックを外す

### 2. 必要な権限を付与

**Repository permissions:**
- **Issues**: Read and write

### 3. インストール

1. GitHub App作成後、**Install App** をクリック
2. アカウント/Organizationを選択
3. アクセスするリポジトリを選択：
   - All repositories（すべて）
   - Only select repositories（特定のリポジトリのみ）

### 4. 認証情報の取得

#### App ID
- GitHub Apps の詳細ページに表示されている数字

#### Private Key（秘密鍵）
1. GitHub Appの設定ページで **Generate a private key** をクリック
2. `.pem` ファイルがダウンロードされる
3. ファイルの内容全体をコピー（`-----BEGIN RSA PRIVATE KEY-----` から `-----END RSA PRIVATE KEY-----` まで）

## シークレットの登録

### リポジトリレベルで登録

各リポジトリで以下の手順を実行：

1. リポジトリ → **Settings**
2. **Secrets and variables** → **Actions**
3. **New repository secret** をクリック
4. 以下の2つを登録：

**APP_ID**
- Name: `APP_ID`
- Secret: GitHub AppのID（数字）

**APP_PRIVATE_KEY**
- Name: `APP_PRIVATE_KEY`
- Secret: ダウンロードした秘密鍵ファイルの内容全体

### 注意事項

- 個人アカウントの場合、アカウント全体のシークレットは設定できないため、リポジトリごとに登録が必要
- Organizationの場合は、Organization secretsとして登録可能（全リポジトリで共有）

## 動作確認

1. ワークフローファイルを `.github/workflows/setup-labels.yml` に配置
2. mainブランチにpush
3. **Actions** タブで実行状況を確認
4. エラーがなければ、**Issues** → **Labels** でラベルが作成されていることを確認

## トラブルシューティング

エラーが発生した場合は [トラブルシューティングガイド](./troubleshooting.md) を参照してください。
