#!/bin/bash
# practice-sync.sh - practice 仓库同步脚本
# 用法: bash scripts/practice-sync.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
LOG="$REPO_DIR/outputs/sync-log.md"

echo "=== 同步开始: $(date '+%Y-%m-%d %H:%M') ===" 

cd "$REPO_DIR"

# 1. pull 最新代码
echo "[1/4] git pull..."
git pull --quiet 2>&1 | tail -2

# 2. 运行 pytest
echo "[2/4] 运行 pytest..."
PYTEST_OUTPUT=$(python3 -m pytest week1_string_utils/ -v --tb=short 2>&1)
PYTEST_EXIT=$?
echo "$PYTEST_OUTPUT" | tail -10

# 3. 统计结果
PASSED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= passed)' | head -1)
FAILED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= failed)' | head -1)
TOTAL=${PASSED:-0}
FAILED_COUNT=${FAILED:-0}

# 4. 追加 sync-log.md
{
  echo ""
  echo "### $(date '+%Y-%m-%d %H:%M')"
  echo ""
  echo "| 项目 | 结果 |"
  echo "|------|------|"
  echo "| 测试用例 | ${TOTAL} passed |"
  echo "| 失败 | ${FAILED_COUNT} |"
  echo "| 详细 | \`\`\`" 
  echo "$PYTEST_OUTPUT" | grep -E '(PASSED|FAILED|passed|failed)' | sed 's/^/|/;s/$/|/' | head -20
  echo "| \`\`\` |"
} >> "$LOG"

# 5. git push
echo "[3/4] git add + commit..."
git add outputs/ 2>/dev/null || true
CHANGES=$(git status --short)
if [ -n "$CHANGES" ]; then
  git commit -m "chore: 同步测试结果 $(date '+%m%d %H:%M')" 2>&1 | tail -2
  git push 2>&1 | tail -2
  echo "[4/4] 已 push"
else
  echo "[4/4] 无变更，跳过 push"
fi

echo "=== 同步完成 ==="
