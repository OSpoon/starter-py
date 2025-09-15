# Python Project Template

🚀 一个现代化的 Python 项目模板，包含完整的开发工具链和 Web 演示功能。

## 环境要求

- Python >= 3.12
- [uv](https://docs.astral.sh/uv/) (推荐的 Python 包管理器)

## 快速开始

### 1. 创建新项目

在 [GitHub 页面](https://github.com/OSpoon/starter-py) 点击 **"Use this template"** 按钮创建你的新项目。

### 2. 克隆项目

```bash
git clone https://github.com/yourusername/your-new-project.git
cd your-new-project
```

### 3. 初始化项目

```bash
make init NAME=my-awesome-project
```

### 4. 启动 Web 演示

```bash
make web
```

浏览器将自动打开 `http://localhost:8501` 演示页面。

## 开发命令

```bash
make web     # 启动 Web 演示
make lint    # 代码格式化和检查
make test    # 运行测试
make build   # 构建包
make clean   # 清理临时文件
make help    # 查看所有命令
```

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。
