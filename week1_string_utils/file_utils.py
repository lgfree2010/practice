

def read_file(path, mode = 'r'):
    with open(path, mode) as f:
        return f.read()
    
def write_file(path, content, mode = 'w'):
    with open(path, mode) as f:
        f.write(content)
