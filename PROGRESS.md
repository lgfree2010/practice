# Python 测试练习进度

## 练习计划（4/2 - 4/8，每天2小时）

| 日期 | 星期 | 练习内容 | 状态 |
|------|------|----------|------|
| 4/2 | 周四 | Python 基础回顾 & 测试环境搭建 | ⬜ |
| 4/3 | 周五 | pytest 框架入门 | ⬜ |
| 4/4 | 周六 | 单元测试：函数测试用例设计 | ⬜ |
| 4/5 | 周日 | 自动化测试：文件/接口/命令行 | ⬜ |
| 4/6 | 周一 | 数据驱动测试 & 参数化 | ⬜ |
| 4/7 | 周二 | 综合练习 | ✅ 已完成 |
| 4/8 | 周三 | 查漏补缺 & 总结 | 🔄 进行中 |

---

## 里程碑

### ✅ 环境搭建完成（4/7）
- GitHub SSH 配置完成
- venv 虚拟环境 + pytest 安装成功
- VSCode 配置 Python 解释器
- 项目结构：`week1_string_utils/`

### ✅ week1_string_utils — sum() 函数 TDD（4/7）
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

### 🔄 下一步练习方向
- [ ] reverse_string() — 字符串反转
- [ ] max_of_three() — 三数最大值
- [ ] 参数化测试 @pytest.mark.parametrize
- [ ] fixture 共享资源

---

## 踩坑记录

### 坑1：venv 路径问题
- **问题：** Python 文件放到了 `venv/` 目录下
- **解决：** 文件放项目根目录，venv 只放环境文件

### 坑2：PowerShell 执行策略限制
- **问题：** `.\venv\Scripts\activate` 报 PSSecurityException
- **解决：** 使用 CMD 代替 PowerShell

### 坑3：pytest 找不到测试文件
- **问题：** 文件名 `test1.py` 不符合 pytest 规范
- **解决：** 改名为 `test_*.py`（下划线）

### 坑4：pip 安装超时
- **问题：** 访问 PyPI 超时 ReadTimeout
- **解决：** 使用清华镜像源 `pip install pytest -i https://pypi.tuna.tsinghua.edu.cn/simple`

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
