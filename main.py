import requests
import os
import re
import shutil

device = (
    "cmsis-device-c0",
    "cmsis-device-f0",
    "cmsis-device-f1",
    "cmsis-device-f2",
    "cmsis-device-f3",
    "cmsis-device-f4",
    "cmsis-device-f7",
    "cmsis-device-g0",
    "cmsis-device-g4",
    "cmsis-device-h5",
    "cmsis-device-h7",
    "cmsis-device-h7rs",
    "cmsis-device-l0",
    "cmsis-device-l1",
    "cmsis-device-l4",
    "cmsis-device-l5",
    "cmsis-device-n6",
    "cmsis-device-u0",
    "cmsis-device-u3",
    "cmsis-device-u5",
    "cmsis-device-wb",
    "cmsis-device-wb0",
    "cmsis-device-wba",
    "cmsis-device-wl",
    "cmsis-device-wl3",
    "cmsis_device_mp13",
)

def download_github_repo_contents(owner, repo, path="", local_dir="."):
    """下载GitHub仓库指定路径下的所有内容到本地
    Args:
        owner (str): 仓库所有者
        repo (str): 仓库名称
        path (str, optional): 仓库中的路径. 默认为 ""
        local_dir (str, optional): 本地保存目录. 默认为当前目录
    """
    url = f"https://api.github.com/repos/{owner}/{repo}/contents/{path}"
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"获取失败: {response.status_code}")
        return
    
    # 确保本地目录存在
    os.makedirs(local_dir, exist_ok=True)
    
    for item in response.json():
        item_path = os.path.join(local_dir, item["name"])
        
        if item["type"] == "dir":
            # 如果是目录，递归下载
            new_path = f"{path}/{item['name']}" if path else item["name"]
            download_github_repo_contents(owner, repo, new_path, item_path)
        elif download_url := item["download_url"]:
            # 检查文件是否已存在
            if os.path.exists(item_path):
                # print(f"文件已存在，跳过下载: {item['name']}")
                continue

            # 如果是文件且有下载URL，直接下载
            # print(f"下载文件: {item['name']}")
            file_response = requests.get(download_url)
            
            if file_response.status_code == 200:
                with open(item_path, "wb") as f:
                    f.write(file_response.content)
            else:
                print(f"下载文件 {item['name']} 失败: {file_response.status_code}")

def copy_directory(src, dst):
    """复制源目录到目标目录
    
    Args:
        src (str): 源目录路径
        dst (str): 目标目录路径
    """
    # 确保目标目录存在
    os.makedirs(dst, exist_ok=True)
    
    # 遍历源目录下的所有文件和子目录
    for item in os.listdir(src):
        src_item = os.path.join(src, item)
        dst_item = os.path.join(dst, item)
        
        if os.path.isdir(src_item):
            # 如果是目录，递归复制
            copy_directory(src_item, dst_item)
        else:
            # 如果是文件，直接复制
            # 确保目标目录存在
            os.makedirs(os.path.dirname(dst_item), exist_ok=True)
            shutil.copy2(src_item, dst_item)
            # print(f'已复制文件: {dst_item}')

def clean_file_content(content):
    """清理文件内容：删除空白行，清理空白字符
    
    Args:
        content (str): 原始文件内容
    Returns:
        str: 处理后的文件内容
    """
    # 移除多行注释
    content = re.sub(r'/\*[^*]*\*+(?:[^/*][^*]*\*+)*/', '', content)
    
    # 处理每一行
    lines = content.splitlines()
    cleaned_lines = []
    for line in lines:
        # 去除行首和行尾的空白字符
        line = line.strip()
        # 将行内多个空白字符替换为一个空格
        line = re.sub(r'\s+', ' ', line)
        # 只保留非空行
        if line:
            cleaned_lines.append(line)
    
    # 重新组合所有行
    return '\n'.join(cleaned_lines)

def process_files(directory):
    """递归处理目录下的所有文件
    
    Args:
        directory (str): 要处理的目录路径
    """
    # 遍历目录下的所有文件和子目录
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                # 读取文件内容
                with open(file_path, 'r', encoding='windows-1252') as f:
                    content = f.read()
                
                # 处理文件内容
                new_content = clean_file_content(content)
                
                # 如果内容有变化，写回文件
                if new_content != content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f'已处理文件: {file_path}')
            except UnicodeDecodeError:
                print(f'跳过二进制文件: {file_path}')
            except Exception as e:
                print(f'处理文件 {file_path} 时出错: {str(e)}')

def main():
    # 遍历device元组中的所有仓库
    for repo in device:
        print(f"开始下载仓库: {repo}")
        download_github_repo_contents("STMicroelectronics", repo, "Source/Templates/gcc", f"startup/1_download/{repo}")
        print(f"仓库 {repo} 下载完成!")
    print("所有仓库下载完成!")

    # 复制1_download目录到2_clean目录
    print("开始复制1_download目录到2_clean目录...")
    copy_directory("startup/1_download", "startup/2_clean")
    print("复制完成!")

    # 处理2_clean目录中的文件
    print("开始处理2_clean目录中的文件...")
    process_files('startup/2_clean')
    print("处理完成!")

# 使用示例：
if __name__ == '__main__':
    main()
