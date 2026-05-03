#!/bin/bash
# practice-sync.sh - practice 仓库同步脚本
# 触发指令: 「同步practice」
# 功能: git pull → 遍历各练习目录运行pytest → 检测新练习 → 更新 practice-qa.md → git push

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
QA_FILE="$REPO_DIR/outputs/practice-qa.md"
LOG="$REPO_DIR/outputs/sync-log.md"

echo "=== 同步开始: $(date '+%Y-%m-%d %H:%M') ==="

cd "$REPO_DIR"

# 1. git pull
echo "[1/5] git pull..."
git pull --quiet 2>&1 | tail -2

# 2. 收集所有练习目录
#    遍历 week* 开头的目录，如果存在 tests/test_*.py 或直接有 test_*.py 则收集
echo "[2/5] 检测练习目录..."
EXERCISE_DIRS=()

# 方式：直接用ls遍历week开头的目录
for dir in week*; do
  if [ ! -d "$dir" ]; then
    continue
  fi

  name=$(basename "$dir")

  # 检查是否有测试文件
  if [ -d "$dir/tests" ] && ls "$dir/tests/test_"*.py 1>/dev/null 2>&1; then
    EXERCISE_DIRS+=("$dir")
  elif ls "$dir/test_"*.py 1>/dev/null 2>&1; then
    EXERCISE_DIRS+=("$dir")
  fi
done

echo "      发现练习目录: ${EXERCISE_DIRS[*]:-无}"

# 3. 遍历运行 pytest，收集结果
echo "[3/5] 运行 pytest..."
TOTAL_PASSED=0
TOTAL_FAILED=0
PYTEST_SUMMARY=""

for ex_dir in "${EXERCISE_DIRS[@]}"; do
  ex_name=$(basename "$ex_dir")
  echo "      运行 $ex_name..."

  # 清理缓存避免模块冲突
  rm -rf "$ex_dir/__pycache__" "$ex_dir/tests/__pycache__" 2>/dev/null || true

  # 根据目录结构选择运行方式
  if [ "$ex_name" = "week1_string_utils" ]; then
    output=$(python3 -m pytest "$ex_dir" -v --tb=short 2>&1)
  else
    # week2 及以后：有 tests/ 子目录，需要 cd 到练习目录内运行
    output=$(cd "$ex_dir" && python3 -m pytest tests/ -v --tb=short 2>&1)
  fi

  passed=$(echo "$output" | grep -oP '\d+(?= passed)' | tail -1 || echo "0")
  failed=$(echo "$output" | grep -oP '\d+(?= failed)' | tail -1 || echo "0")
  TOTAL_PASSED=$((TOTAL_PASSED + passed))
  TOTAL_FAILED=$((TOTAL_FAILED + failed))

  echo "      $ex_name: $passed passed / $failed failed"
  PYTEST_SUMMARY="$PYTEST_SUMMARY $ex_name: $passed passed / $failed failed;"
done

# 4. 检测并补全 practice-qa.md 新练习章节
echo "[4/5] 检测新练习章节..."
NEW_COUNT=0
for ex_dir in "${EXERCISE_DIRS[@]}"; do
  week_name=$(basename "$ex_dir" | sed 's/_/ /g')
  week_num=$(echo "$week_name" | grep -oP 'Week \d+' || echo "")

  if [ -z "$week_num" ]; then
    continue
  fi

  if ! grep -q "$week_num" "$QA_FILE" 2>/dev/null; then
    echo "      发现新练习: $week_name"
    cat >> "$QA_FILE" << EOF

## $week_name -（待补充）

### 📋 练习要求

> 练习要求待补充

---

### 💻 代码示范

> 代码示范待补充

---

### ✅ 测试用例清单

> 测试用例清单待补充

---

### 📝 Q&A 记录

> Q&A 记录待补充

EOF
    NEW_COUNT=$((NEW_COUNT + 1))
  fi
done

if [ $NEW_COUNT -gt 0 ]; then
  echo "      新增 ${NEW_COUNT} 个练习章节占位符"
fi

# 5. 追加 sync-log.md
{
  echo ""
  echo "### $(date '+%Y-%m-%d %H:%M')"
  echo ""
  echo "| 项目 | 结果 |"
  echo "|------|------|"
  if [ "$TOTAL_FAILED" -eq 0 ]; then
    STATUS="✅ 全部通过"
  else
    STATUS="⚠️ 有失败"
  fi
  echo "| 测试用例 | ${TOTAL_PASSED} passed / ${TOTAL_FAILED} failed |"
  echo "| 状态 | $STATUS |"
} >> "$LOG"

# 6. git push 变更
echo "[5/5] git add + commit..."
git add outputs/ 2>/dev/null || true
git add scripts/practice-sync.sh 2>/dev/null || true
git add . 2>/dev/null || true
CHANGES=$(git status --short)
if [ -n "$CHANGES" ]; then
  git commit -m "chore: 同步测试结果 $(date '+%m%d %H:%M')" 2>&1 | tail -1
  git push 2>&1 | tail -2
  echo "[6/6] 已 push"
else
  echo "[6/6] 无变更，跳过 push"
fi

echo ""
echo "=== 汇总结果 ==="
echo "总计: ${TOTAL_PASSED} passed / ${TOTAL_FAILED} failed"
echo "=== 同步完成 ==="