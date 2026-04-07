# Python 测试练习进度

## 练习计划（4/8 - 4/14，每天2小时）

| 日期 | 星期 | 练习内容 | 状态 |
|------|------|----------|------|
| 4/8 | 周三 | Python 基础回顾 & 测试环境搭建 | ✅ 已完成 |
| 4/9 | 周四 | pytest 框架入门 | 🔄 今日 |
| 4/10 | 周五 | 单元测试：函数测试用例设计 | ⬜ |
| 4/11 | 周六 | 自动化测试：文件/接口/命令行 | ⬜ |
| 4/12 | 周日 | 数据驱动测试 & 参数化 | ⬜ |
| 4/13 | 周一 | 综合练习 | ⬜ |
| 4/14 | 周二 | 查漏补缺 & 总结 | ⬜ |

---

## 每日详细任务

### Day 1（4/8）：Python 基础 & 环境搭建 ✅
- [x] 复习：变量、数据类型、字符串、列表、字典
- [x] 复习：条件语句、循环、函数
- [x] 安装 pytest + venv
- [x] VSCode 配置 Python 解释器
- [x] GitHub SSH 配置完成
- [x] 项目结构创建：week1_string_utils/

### Day 2（4/9）：pytest 入门
- [ ] pytest 文件发现规则（test_*.py）
- [ ] assert 断言
- [ ] 写3个简单测试用例
- [ ] 运行 pytest 验证

### Day 3（4/10）：函数测试用例设计
- [ ] 等价类、边界值设计原则
- [ ] @pytest.mark.parametrize 参数化
- [ ] fixture 共享资源
- [ ] pytest.raises 异常测试

### Day 4（4/11）：自动化测试
- [ ] 文件读写自动化测试
- [ ] subprocess 调用外部命令
- [ ] 命令行测试

### Day 5（4/12）：数据驱动
- [ ] @pytest.mark.parametrize 进阶
- [ ] CSV/JSON 数据驱动

### Day 6（4/13）：综合练习
- [ ] 确定测试目标
- [ ] 完整设计 + 运行

### Day 7（4/14）：收尾
- [ ] 回顾难点、整理代码片段
- [ ] 总结、下一步规划

---

## 里程碑

### ✅ week1_string_utils — sum() 函数 TDD（4/8）
- **函数：** `my_sum(numbers)` — 列表求和
- **测试用例：** 7个全覆盖
  - `test_sum_equals_6` — 正常正数 [1,2,3] → 6
  - `test_sum_equals_0` — 空列表 [] → 0
  - `test_sum_negative` — 全负数 [-1,-2,-3] → -6
  - `test_sum_float` — 浮点数 [1.6,2.4,3.0] → 7.0
  - `test_sum_mixed` — 混合正负 [1,-2,3] → 2
  - `test_sum_large` — 大数 [1000000,2000000,3000000] → 6000000
  - `test_sum_single_element` — 单元素 [5] → 5
- **状态：** 全部通过 ✅

### ✅ week1_string_utils — is_prime() 函数 TDD（4/8）
- **函数：** `is_prime(n)` — 判断质数
- **测试用例：** 7个
  - `test_is_prime_2` — 最小质数 2 → True
  - `test_is_prime_3` — 质数 3 → True
  - `test_is_prime_4` — 非质数 4 → False
  - `test_not_prime_1` — 1 不是质数 → False
  - `test_not_prime_0` — 0 不是质数 → False
  - `test_prime_negative` — 负数 -5 → False
  - `test_prime_large` — 大数 997(质数)/10091000(非质数)
- **状态：** 全部通过 ✅
- **算法优化：** 基础版（遍历到n）→ 优化版（只需遍历到√n）

### 🔄 下一步练习方向
- [ ] reverse_string() — 字符串反转
- [ ] max_of_three() — 三数最大值
- [ ] 参数化测试 @pytest.mark.parametrize
- [ ] fixture 共享资源

---

## 踩坑记录

### ✅ 坑1：venv 路径问题
- **问题：** Python 文件放到了 `venv/` 目录下
- **解决：** 文件放项目根目录，venv 只放环境文件

### ✅ 坑2：PowerShell 执行策略限制
- **问题：** `.\venv\Scripts\activate` 报 PSSecurityException
- **解决：** 使用 CMD 代替 PowerShell

### ✅ 坑3：pytest 找不到测试文件
- **问题：** 文件名 `test1.py` 不符合 pytest 规范
- **解决：** 改名为 `test_*.py`（下划线）

### ✅ 坑4：pip 安装超时
- **问题：** 访问 PyPI 超时 ReadTimeout
- **解决：** 使用清华镜像源 `pip install pytest -i https://pypi.tuna.tsinghua.edu.cn/simple`

### ✅ 坑5：导入路径错误
- **问题：** `from test_string_utils import is_prime`（从测试文件导入）
- **解决：** `from string_utils import is_prime`（从源文件导入）

---

## 代码审核记录

| 日期 | 分支 | 内容 | 状态 |
|------|------|------|------|
| 4/7 | fix/sum-naming | sum→my_sum, 删除print | ✅ |
| 4/7 | main | 合并fix分支，7个测试全绿 | ✅ |
| 4/8 | main | is_prime TDD，7个测试全绿 | ✅ |

---

## GitHub 仓库

- https://github.com/lgfree2010/practice
- 练习项目：week1_string_utils/
- 状态：✅ 已push并review通过
