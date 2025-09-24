# Python 项目模板

🚀 基于 Copier 的现代 Python 项目模板，包含 uv + Streamlit + 完整工具链。

## 快速开始

```bash
# 1. 安装 copier
pip install copier

# 2. 创建新项目（项目名自动从目录名获取）
copier copy https://github.com/OSpoon/starter-py my-project --trust

# 3. 开始使用
cd my-project
make test    # 运行测试
make web     # 启动 Web 演示（如果包含）
```

## 包含功能

- 🏗️ **现代工具链**: uv + ruff + mypy + pytest + pre-commit
- 🎯 **可选功能**: Streamlit Web 应用、CLI 示例、GitHub Actions
- 📦 **智能命名**: 项目名自动从目录名获取
- 🚀 **一键启动**: 自动安装依赖、初始化 Git、设置 hooks

## 常用命令

```bash
make test      # 运行测试
make lint      # 代码检查
make web       # 启动 Web 应用
make help      # 查看所有命令
```

## 环境要求

- Python 3.13+
- [copier](https://copier.readthedocs.io/)

## 问题解决

遇到问题时：
1. 确保添加 `--trust` 选项
2. 检查 Python 版本 >= 3.13
3. 查看生成项目中的 `make help`

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。
