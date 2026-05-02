# Python 练习手册

> 本文件是 Python 学习期间的完整记录，包括练习要求、代码示范、测试用例清单、Q&A 问答。
> 方便写代码时直接查看，不用翻聊天记录。
>
> **触发同步**：`同步practice`

---

## ⚡ 速查（写代码前先看这里）

| 模式 | 写法 | 示例 |
|------|------|------|
| 参数化 | `@pytest.mark.parametrize("input,expected", [...])` | 下方示例 |
| √n 优化 | `for i in range(2, int(n**0.5)+1)` | is_prime 优化版 |
| 异常抛出 | `raise ValueError("description")` | 下方示例 |
| fixture | `@pytest.fixture` | 模板项目 |
| assert 列表 | `assert result == expected` | 通用 |

---

## 📌 常用命令备忘

```bash
# 本地 Windows
cd D:\pytest\practice
git add .
git commit -m "message"
git push

# 服务器同步（发送「同步practice」）
# 自动执行: git pull → pytest → 更新本文件 → git push
```

---

## Week 1 - 字符串工具（TDD 练习）

### 📋 练习要求

**目标**：4个函数，每个函数配套测试，用 TDD 方式开发

| 函数 | 输入 | 输出 | 备注 |
|------|------|------|------|
| `is_prime(n)` | int | bool | 质数判断 |
| `my_sum(a, b)` | int, int | int | 两数之和 |
| `reverse_string(s)` | str | str | 反转字符串 |
| `max_of_three(a, b, c)` | int, int, int | int | 最大值 |

**约束**：
- 先写测试，再写实现（TDD）
- 每个函数 ≥ 3 个测试用例
- 使用 `pytest.mark.parametrize` 参数化

---

### 💻 代码示范

#### is_prime 优化版（√n 优化）

```python
# week1_string_utils/is_prime.py
def is_prime(n: int) -> bool:
    """判断质数 - √n 优化版"""
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
```

**优化点**：只遍历到 √n，减少循环次数。

#### 参数化示例

```python
# week1_string_utils/test_is_prime.py
import pytest
from is_prime import is_prime

@pytest.mark.parametrize("input,expected", [
    (0,  False),   # 边界
    (1,  False),   # 边界
    (2,  True),    # 最小质数
    (3,  True),
    (4,  False),
    (17, True),    # 质数
    (100, False),   # 合数
])
def test_is_prime(input, expected):
    assert is_prime(input) == expected
```

#### 异常抛出示例

```python
# week1_string_utils/string_utils.py
def reverse_string(s: str) -> str:
    if not isinstance(s, str):
        raise TypeError("输入必须是字符串")
    return s[::-1]
```

---

### ✅ 测试用例清单

#### is_prime 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 边界-0 | 0 | False |
| 边界-1 | 1 | False |
| 最小质数 | 2 | True |
| 奇数质数 | 3 | True |
| 偶数合数 | 4 | False |
| 质数 | 17 | True |
| 大合数 | 100 | False |
| 负数 | -3 | False |

#### reverse_string 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 英文 | "hello" | "olleh" |
| 中文 | "你好世界" | "界界好你" |
| 混合 | "hello world" | "dlrow olleh" |
| 空字符串 | "" | "" |
| 单字符 | "a" | "a" |
| 对称 | "racecar" | "racecar" |
| 特殊字符 | "!@#$%" | "%$#@!" |

---

### 📝 Q&A 记录

#### Q: 如何开始 TDD 练习？
**标签**: #TDD #Week1

**A**: 先写测试文件（test_*.py），运行看到 FAIL，再写实现让测试通过。

---

#### Q: 参数化的好处是什么？
**标签**: #pytest #参数化 #Week1

**A**: 用一组数据跑同一个测试，减少重复代码。比如 is_prime 的 8 个用例写一行 `@pytest.mark.parametrize` 搞定。

---

#### Q: is_prime 边界怎么处理？
**标签**: #边界条件 #Week1

**A**: n < 2 → 直接返回 False，不需要循环判断。

---

#### Q: 之前 review 发现的 4 项不足是？
**标签**: #AI-review #Week1 #待修复

**A**: 
1. ❌ 丢失了 2 条测试用例（`test_reverse_numbers` + `test_reverse_mixed_Chinese_English`）
2. ❌ 底部有注释掉的旧函数待清理
3. ❌ `is_prime` 未优化，仍遍历到 n（应优化到 √n）
4. ❌ 未实践 CSV/JSON 数据驱动

---

## Week 2 - 文件操作 & 异常（待开启）

> 每次新练习开始时，在这里补充练习要求 + 代码示范。

---

## 更新记录

| 日期 | 内容 |
|------|------|
| 2026-05-03 | 初始建立，Week 1 内容补全 |