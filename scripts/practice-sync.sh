#!/bin/bash
# practice-sync.sh - practice 仓库同步脚本
# 触发指令: 「同步practice」
# 功能: git pull → pytest → 更新 practice-qa.md → git push

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
QA_FILE="$REPO_DIR/outputs/practice-qa.md"
LOG="$REPO_DIR/outputs/sync-log.md"

echo "=== 同步开始: $(date '+%Y-%m-%d %H:%M') ===" 

cd "$REPO_DIR"

# 1. git pull
echo "[1/4] git pull..."
git pull --quiet 2>&1 | tail -2

# 2. 运行 pytest
echo "[2/4] 运行 pytest..."
PYTEST_OUTPUT=$(python3 -m pytest week1_string_utils/ -v --tb=short 2>&1)
PYTEST_EXIT=$?
PYTEST_SUMMARY=$(echo "$PYTEST_OUTPUT" | grep -E "passed|failed" | tail -1)

# 3. 解析结果
if echo "$PYTEST_OUTPUT" | grep -q "0 failed"; then
    STATUS="✅ 全部通过"
else
    STATUS="⚠️ 有失败"
fi

PASSED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= passed)' | head -1)
FAILED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= failed)' | head -1)

# 4. 追加 sync-log.md
{
  echo ""
  echo "### $(date '+%Y-%m-%d %H:%M') $STATUS"
  echo ""
  echo "| 项目 | 结果 |"
  echo "|------|------|"
  echo "| 测试用例 | ${PASSED:-0} passed / ${FAILED:-0} failed |"
  echo "| 状态 | $STATUS |"
} >> "$LOG"

# 5. git push 变更
echo "[3/4] git add + commit..."
git add outputs/ 2>/dev/null || true
git add scripts/practice-sync.sh 2>/dev/null || true
CHANGES=$(git status --short)
if [ -n "$CHANGES" ]; then
  git commit -m "chore: 同步测试结果 $(date '+%m%d %H:%M')" 2>&1 | tail -1
  git push 2>&1 | tail -2
  echo "[4/4] 已 push"
else
  echo "[4/4] 无变更，跳过 push"
fi

echo "=== 同步完成 ==="
echo ""
echo "=== 测试结果 ==="
echo "$PYTEST_SUMMARY"