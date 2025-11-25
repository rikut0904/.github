#!/bin/bash

# 使用方法: ./create-labels.sh [owner]
# 引数なし: 自分のすべてのリポジトリに適用
# 引数あり: 指定したowner/orgのすべてのリポジトリに適用

OWNER=$1

# ラベル定義: 名前|色|説明
labels=(
  "bug|d73a4a|バグ報告"
  "enhancement|a2eeef|新機能追加"
  "documentation|0075ca|ドキュメント改善"
  "refactor|fbca04|リファクタリング"
  "performance|5319e7|パフォーマンス改善"
  "dependencies|0366d6|依存関係の更新"
)

# リポジトリ一覧を取得
if [ -z "$OWNER" ]; then
  echo "自分のすべてのリポジトリにラベルを作成します..."
  repos=$(gh repo list --json nameWithOwner --jq '.[].nameWithOwner' --limit 1000)
else
  echo "${OWNER} のすべてのリポジトリにラベルを作成します..."
  repos=$(gh repo list "$OWNER" --json nameWithOwner --jq '.[].nameWithOwner' --limit 1000)
fi

if [ -z "$repos" ]; then
  echo "リポジトリが見つかりませんでした"
  exit 1
fi

# 各リポジトリに対してラベルを作成
for repo in $repos; do
  echo ""
  echo "=== $repo ==="

  # 既存のラベルをすべて削除
  gh label list --repo "$repo" --json name --jq '.[].name' | while read -r label; do
    gh label delete "$label" --repo "$repo" --yes 2>/dev/null
  done

  # 新しいラベルを作成
  for label in "${labels[@]}"; do
    IFS='|' read -r name color description <<< "$label"
    gh label create "$name" --repo "$repo" --color "$color" --description "$description" 2>/dev/null
    echo "  Created: $name"
  done
done

echo ""
echo "完了しました"
