# Python Project Template with Copier

🚀 一个现代化的 Python 项目模板，使用 [Copier](https://copier.readthedocs.io/) 构建，包含完整的开发工具链和 Web 演示功能。

## 环境要求

- Python >= 3.13
- [uv](https://docs.astral.sh/uv/) (推荐的 Python 包管理器)
- [copier](https://copier.readthedocs.io/) (项目模板工具)

## 快速开始

### 1. 安装 Copier

```bash
pip install copier
# 或者
uv tool install copier
```

### 2. 从模板创建新项目

```bash
# 从 GitHub 创建项目（使用 copier 分支）
copier copy https://github.com/OSpoon/starter-py --vcs-ref=copier my-new-project --trust

# 或者从本地路径创建
copier copy /path/to/starter-py my-new-project --trust
```

> **注意**: 需要使用 `--trust` 参数，因为模板包含自动化任务（如依赖安装和 Git 初始化）。

### 3. 进入项目目录

```bash
cd my-new-project
uv sync --extra dev
```

### 4. 验证项目设置

```bash
# 运行测试
make test

# 检查代码质量
make lint

# 查看所有可用命令
make help
```

### 5. 启动 Web 演示 (如果包含 Streamlit)

```bash
make web
```

浏览器将自动打开 `http://localhost:8501` 演示页面。

## 模板特性

### 🏗️ 现代化工具链

- **uv**: 快速的 Python 包管理器，比 pip 更快
- **Ruff**: 现代的代码格式化和 lint 工具
- **MyPy**: 类型检查，确保代码质量
- **pytest**: 全面的测试框架，支持并行测试
- **pre-commit**: Git 提交前的代码检查

### 🎯 可选功能

- **Streamlit Web 应用**: 交互式 Web 界面演示，包含计算器、示例和性能测试
- **命令行接口**: 程序化使用示例，展示如何在脚本中使用你的包
- **GitHub Actions**: 自动化 CI/CD 流程，包括测试、类型检查和 PyPI 发布
- **VS Code 配置**: 预配置的开发环境，包括调试、扩展推荐和设置
- **MIT 许可证**: 开源友好的许可证
- **Python 3.13**: 最新的 Python 版本支持

### 📁 项目结构

```
my-new-project/
├── .github/                 # GitHub 配置
│   ├── workflows/           # CI/CD 流程
│   └── copilot-instructions.md
├── .vscode/                 # VS Code 配置
├── src/
│   └── my_package/          # 你的 Python 包
│       ├── __init__.py      # 包初始化
│       ├── math.py          # 示例模块
│       └── py.typed         # 类型标记文件
├── tests/                   # 测试目录
│   └── math_test.py         # 示例测试
├── .gitignore               # Git 忽略规则
├── .pre-commit-config.yaml  # Pre-commit 配置
├── app.py                   # Streamlit Web 应用 (可选)
├── main.py                  # 命令行接口示例 (可选)
├── pyproject.toml           # 项目配置和依赖
├── Makefile                 # 开发命令快捷方式
├── LICENSE                  # MIT 许可证
└── README.md                # 项目文档
```

## 开发命令

```bash
make lint      # 完整的代码质量检查 (ruff + mypy)
make format    # 快速代码格式化 (仅 ruff)
make test      # 运行测试套件
make build     # 构建 Python 包
make clean     # 清理临时文件和缓存
make web       # 启动 Streamlit Web 应用 (如果包含)
make help      # 显示所有可用命令
```

### Pre-commit 钩子

如果选择了安装 pre-commit 钩子，每次 git 提交时会自动运行：

- 代码格式化 (ruff-format)
- 代码检查 (ruff)
- 类型检查 (mypy)

## 获取帮助

- 查看 [Copier 文档](https://copier.readthedocs.io/)
- 提交 [Issue](https://github.com/OSpoon/starter-py/issues)
- 查看生成项目中的 `make help` 获取可用命令

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。
