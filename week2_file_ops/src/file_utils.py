#读取函数
def read_file(path):
    with open(path, encoding="utf-8") as f:
        return f.read()
    
#写入函数
def write_file(path, content):
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
        
#统计行数函数
def count_lines(path):
    with open(path, encoding="utf-8") as f:
        return len(f.readlines())
    
#读取CSV文件函数
def read_csv(path):
    result = []
    with open(path, encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            result.append(row)
    return result