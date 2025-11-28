#!/bin/bash

# 使用方法: ./sync-files.sh [owner]
# 引数なし: 自分のすべてのリポジトリに適用
# 引数あり: 指定したowner/orgのすべてのリポジトリに適用

OWNER=$1
SCRIPT_DIR=$(cd $(dirname $0); pwd)
TEMPLATE_DIR=$(dirname "$SCRIPT_DIR")

# コピー対象ファイルのパス
CONTRIBUTING_FILE="$TEMPLATE_DIR/CONTRIBUTING.md"
LICENSE_FILE="$TEMPLATE_DIR/LICENSE"

# ファイルの存在確認
if [ ! -f "$CONTRIBUTING_FILE" ]; then
  echo "エラー: CONTRIBUTING.md が見つかりません: $CONTRIBUTING_FILE"
  exit 1
fi

if [ ! -f "$LICENSE_FILE" ]; then
  echo "エラー: LICENSE が見つかりません: $LICENSE_FILE"
  exit 1
fi

# リポジトリ一覧を取得
if [ -z "$OWNER" ]; then
  echo "自分のすべてのリポジトリにファイルを同期します..."
  repos=$(gh repo list --json nameWithOwner --jq '.[].nameWithOwner' --limit 1000)
else
  echo "${OWNER} のすべてのリポジトリにファイルを同期します..."
  repos=$(gh repo list "$OWNER" --json nameWithOwner --jq '.[].nameWithOwner' --limit 1000)
fi

if [ -z "$repos" ]; then
  echo "リポジトリが見つかりませんでした"
  exit 1
fi

# 一時ディレクトリを作成
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# 各リポジトリに対してファイルをコピー
for repo in $repos; do
  echo ""
  echo "=== $repo ==="

  # リポジトリをクローン
  REPO_DIR="$TEMP_DIR/$(basename $repo)"
  if ! gh repo clone "$repo" "$REPO_DIR" -- --depth 1 2>/dev/null; then
    echo "  スキップ: クローンに失敗しました"
    continue
  fi

  cd "$REPO_DIR"

  # デフォルトブランチを取得
  DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

  # ファイルをコピー
  cp "$CONTRIBUTING_FILE" "$REPO_DIR/CONTRIBUTING.md"
  cp "$LICENSE_FILE" "$REPO_DIR/LICENSE"

  # ファイルを追加
  git add CONTRIBUTING.md LICENSE

  # 変更があるか確認（addした後にチェック）
  if git diff --cached --quiet; then
    echo "  変更なし"
    cd "$TEMP_DIR"
    rm -rf "$REPO_DIR"
    continue
  fi

  # 変更をコミット
  git commit -m "docs/CONTRIBUTING.mdとLICENSEを同期

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

  # プッシュ
  if git push origin "$DEFAULT_BRANCH" 2>/dev/null; then
    echo "  ✓ 同期完了"
  else
    echo "  ✗ プッシュに失敗しました"
  fi

  # クリーンアップ
  cd "$TEMP_DIR"
  rm -rf "$REPO_DIR"
done

echo ""
echo "完了しました"
