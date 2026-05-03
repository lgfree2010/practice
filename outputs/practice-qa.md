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

## Week 2 - 文件操作 & 异常

### 📋 练习要求

**目标**：4个函数，用 TDD 方式开发

| 函数 | 功能 | 示例 |
|------|------|------|
| `read_file(path)` | 读取文本文件，返回字符串 | `read_file("test.txt")` → `"hello"` |
| `write_file(path, content)` | 写入文本文件 | `write_file("out.txt", "hello")` → 创建文件 |
| `count_lines(path)` | 统计文件行数 | `count_lines("test.txt")` → `10` |
| `read_csv(path)` | 读取 CSV，返回 list of dict | `read_csv("data.csv")` → `[{"name":"A","age":"18"}, ...]` |

**约束**：
- 先写测试，再写实现（TDD）
- 测试文件：`week2_file_ops/tests/test_file_utils.py`
- 实现文件：`week2_file_ops/src/file_utils.py`
- 数据文件：`week2_file_ops/data/`（pytest rootdir 机制见下方）

---

### ⚠️ pytest rootdir 机制（重要教训）

pytest 自动以**运行目录的最近父目录**作为 rootdir，所有相对路径相对于 rootdir 解析。

| 运行 pytest 的位置 | rootdir | `data/grades.csv` 实际找 |
|-------------------|---------|--------------------------|
| `D:\pytest\practice\` | `D:\pytest\practice` | `D:\pytest\practice\data\` ❌ |
| `D:\pytest\practice\week2_file_ops\` | `D:\pytest\practice\week2_file_ops` | `D:\pytest\practice\week2_ops\data\` ✅ |

**正确做法**：切换到 `week2_file_ops/` 目录再运行 pytest：
```bash
cd D:\pytest\practice\week2_file_ops
python -m pytest tests/test_file_utils.py -v
```

---

### 💻 代码示范

#### read_file 实现

```python
def read_file(path):
    with open(path, encoding="utf-8") as f:
        return f.read()
```

**关键点**：不捕获异常，文件不存在自然抛 `FileNotFoundError`。

---

#### write_file 实现

```python
def write_file(path, content):
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
```

**关键点**：`"w"` 模式会自动覆盖原文件。

---

#### count_lines 实现

```python
def count_lines(path):
    with open(path, encoding="utf-8") as f:
        return sum(1 for _ in f)  # 高效：不用读整个文件到内存
```

---

#### read_csv 实现

```python
import csv

def read_csv(path):
    result = []
    with open(path, encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            result.append(row)
    return result
```

**关键点**：
- `newline=""` 是 CSV 标准写法，避免 Windows 换行问题
- `csv.DictReader` 自动把第一行当表头，返回 dict

---

#### sys.path 导入（测试文件顶部）

```python
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from src.file_utils import read_file, write_file, count_lines, read_csv
```

**关键点**：
- 用 `Path(__file__)`（不是字符串），`.resolve()` 转绝对路径
- `parents[1]` = 项目根目录（week2_file_ops/）

---

#### 参数化 + tmp_path（覆盖写入测试）

```python
def test_overwrite_file(tmp_path):
    filepath = tmp_path / "output.txt"
    write_file(str(filepath), "initial content")
    write_file(str(filepath), "overwritten content")
    assert read_file(str(filepath)) == "overwritten content"
```

**关键点**：`tmp_path` 是 pytest 内置 fixture，每个测试函数结束后自动清理。

---

### ✅ 测试用例清单

#### read_file 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 正常读 | `"data/simple_file.txt"` | `"hello"` |
| 空文件 | `"data/empty_file.txt"` | `""` |
| 文件不存在 | `"nonexistent_file.txt"` | 抛 `FileNotFoundError` |

---

#### write_file 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 写入并读出 | 写入 `"test content"` | 读出内容一致 |
| 覆盖写入 | 先写 `"initial"`，再写 `"overwritten"` | 最终内容是 `"overwritten"` |

---

#### count_lines 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 3行文件 | `"data/three_lines.txt"` | `3` |
| 空文件 | `"data/empty.txt"` | `0` |
| 1行文件 | `"data/one_line.txt"` | `1` |

---

#### read_csv 必须覆盖

| 用例 | 输入 | 预期 |
|------|------|------|
| 正常CSV | `"data/grades.csv"` (4行数据) | `len(result) == 4` |
| 空CSV | `"data/empty.csv"` (只有表头) | `len(result) == 0` |
| 文件不存在 | `"data/missing.csv"` | 抛 `FileNotFoundError` |

**grades.csv 示例内容**：
```csv
name,age
A,18
B,19
C,20
D,21
```

---

### 📝 Q&A 记录

#### Q: pytest rootdir 是什么？
**标签**: #pytest #rootdir #Week2

**A**: pytest 自动以**最近父目录**作为 rootdir，所有相对路径相对于 rootdir 解析。数据文件放错位置会导致 FileNotFoundError。

---

#### Q: tmp_path fixture 是什么？
**标签**: #pytest #fixture #Week2

**A**: pytest 内置 fixture，每个测试函数创建独立的临时目录，函数结束后自动清理。用于文件写入测试，避免污染真实目录。

---

#### Q: 为什么 CSV 要用 `newline=""`？
**标签**: #CSV #Python #Week2

**A**: Python 官方文档要求的写法，避免 Windows 上的换行符问题。

---

#### Q: `csv.DictReader` 返回什么类型？
**标签**: #CSV #Python #Week2

**A**: 返回 `dict`（不是 `str`）。列名是 key，值是 string。如 `{"name": "A", "age": "18"}`。

---

#### Q: `@pytest.mark.parametrize` 参数名写错了会怎样？
**标签**: #pytest #参数化 #Week2

**A**: 会报 `fixture 'xxx' not found`。参数名必须和函数参数名一致。如 `@pytest.mark.parametrize("n,expected", ...)` → `def test_is_prime(n, expected):`。

---

#### Q: `Path(__file__)` 总是正确吗？
**标签**: #Python #pathlib #Week2

**A**: 基本正确。但要注意：
- 不用引号包 `__file__`（如 `"__file__"` 会变成字符串）
- 字符串路径要用 `Path("path")`
- `.resolve()` 转绝对路径，避免相对路径歧义

---

## 更新记录

| 日期 | 内容 |
|------|------|
| 2026-05-03 | 初始建立，Week 1 内容补全 |
| 2026-05-04 | Week 2 文件操作练习完成，12 测试全通过 |