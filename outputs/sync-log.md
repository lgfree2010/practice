# Practice 仓库 - 同步记录

> 每次 `git pull` + `pytest` 运行后自动追加记录

---

## 使用说明

| 操作 | 指令 |
|------|------|
| 触发同步 | 发送「同步」 |

## 同步脚本

`scripts/practice-sync.sh` - 执行 pull → pytest → 更新本文件 → push


### 2026-05-03 00:37

| 项目 | 结果 |
|------|------|
| 测试用例 | 37 passed |
| 失败 | 0 |
| 详细 | ```
|week1_string_utils/test_1.py::test_sum_equals_6 PASSED                   [  2%]|
|week1_string_utils/test_1.py::test_sum_equals_0 PASSED                   [  5%]|
|week1_string_utils/test_1.py::test_sum_negative PASSED                   [  8%]|
|week1_string_utils/test_1.py::test_sum_float PASSED                      [ 10%]|
|week1_string_utils/test_1.py::test_sum_mixed PASSED                      [ 13%]|
|week1_string_utils/test_1.py::test_sum_large PASSED                      [ 16%]|
|week1_string_utils/test_1.py::test_sum_single_element PASSED             [ 18%]|
|week1_string_utils/test_is_prime.py::test_is_prime_invalid_input[None] PASSED [ 21%]|
|week1_string_utils/test_is_prime.py::test_is_prime_invalid_input[not_a_number] PASSED [ 24%]|
|week1_string_utils/test_is_prime.py::test_is_prime_invalid_input[3.14] PASSED [ 27%]|
|week1_string_utils/test_is_prime.py::test_is_prime[2-True] PASSED        [ 29%]|
|week1_string_utils/test_is_prime.py::test_is_prime[3-True] PASSED        [ 32%]|
|week1_string_utils/test_is_prime.py::test_is_prime[4-False] PASSED       [ 35%]|
|week1_string_utils/test_is_prime.py::test_is_prime[1-False] PASSED       [ 37%]|
|week1_string_utils/test_is_prime.py::test_is_prime[0-False] PASSED       [ 40%]|
|week1_string_utils/test_is_prime.py::test_is_prime[-5-False] PASSED      [ 43%]|
|week1_string_utils/test_is_prime.py::test_is_prime[997-True] PASSED      [ 45%]|
|week1_string_utils/test_is_prime.py::test_is_prime[100010-False] PASSED  [ 48%]|
|week1_string_utils/test_is_prime.py::test_is_prime_sample PASSED         [ 51%]|
|week1_string_utils/test_max_of_three.py::test_max_of_basic PASSED        [ 54%]|
| ``` |
