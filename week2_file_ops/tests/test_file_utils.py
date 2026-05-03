import sys,pytest
from pathlib import Path
# 把项目根目录（week2_file_ops）加入 Python 路径
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from src.file_utils import read_file,read_csv,write_file,count_lines

# read_file测试函数，正常读-文件存在，空文件-""，文件不存在-抛出异常FileNotFoundError
@pytest.mark.parametrize("filename, expected", [
    ("simple_file.txt", "hello"),
    ("empty_file.txt", "")
])
def test_read_file(filename, expected):
    assert read_file(filename) == expected

def test_read_file_not_found():
    with pytest.raises(FileNotFoundError):
        read_file("nonexistent_file.txt")

@pytest.mark.parametrize("filename, expected", [
    ("empty_file.txt", "")
])
def test_read_file_empty(filename, expected):
    assert read_file(filename) == expected

#写入文件测试函数，写入和读取一致，覆盖写入原来的内容没了

def test_write_and_read(tmp_path):
    filepath = tmp_path / "output.txt"
    write_file(str(filepath) , "test content")
    assert read_file(str(filepath)) == "test content"

def test_overwrite_file(tmp_path):
    filepath = tmp_path / "output.txt"
    write_file(str(filepath), "initial content")
    write_file(str(filepath), "overwritten content")
    assert read_file(str(filepath)) == "overwritten content"

#读取csv文件测试函数
def test_read_csv_basic():
    result = read_csv("data/grades.csv")
    assert len(result) == 4
    assert result[0]["name"] == "A"
    assert result[0]["age"] == 18

def test_read_csv_empty():
    result = read_csv("data/empty.csv")
    assert len(result) == 0

def test_read_csv_missing_file():
    with pytest.raises(FileNotFoundError):
        read_csv("data/missing.csv")

#count_line测试函数
@pytest.mark.parametrize("filename, expected", [
    ("three_lines.txt", 3),
    ("empty.txt", 0),
    ("one_line.txt", 1)])
def test_count_lines(filename, expected):
    assert count_lines(filename) == expected