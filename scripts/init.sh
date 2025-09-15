#!/bin/bash
# 项目初始化脚本

set -e

# 检查参数
if [ $# -ne 2 ]; then
    echo "用法: $0 <project_name> <package_name>"
    echo "示例: $0 my-awesome-project my_awesome_project"
    exit 1
fi

PROJECT_NAME="$1"
PACKAGE_NAME="$2"

# 基本验证
if [[ ! $PROJECT_NAME =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "错误: 项目名只能包含字母、数字、下划线和连字符"
    exit 1
fi

if [[ ! $PACKAGE_NAME =~ ^[a-z][a-z0-9_]*$ ]]; then
    echo "错误: 包名只能包含小写字母、数字和下划线，且必须以字母开头"
    exit 1
fi

# 检查是否在正确的目录
if [ ! -f "pyproject.toml" ]; then
    echo "错误: 请在项目根目录下运行此脚本（需要 pyproject.toml 文件）"
    exit 1
fi

# 检查是否有可用的模板包目录
if [ ! -d "src/starter_py" ] && [ ! -d "src/long_image_splitter" ]; then
    echo "错误: 未找到可用的模板包目录"
    exit 1
fi

echo "正在初始化项目: $PROJECT_NAME (包名: $PACKAGE_NAME)"

# 1. 更新 pyproject.toml
echo "更新 pyproject.toml..."
# 更新项目名称
sed -i.bak "s/name = \"starter-py\"/name = \"$PROJECT_NAME\"/g" pyproject.toml
sed -i.bak "s/name = \"LongImageSplitter\"/name = \"$PROJECT_NAME\"/g" pyproject.toml

# 更新 MyPy 包配置
sed -i.bak "s/packages = \[\"starter_py\"\]/packages = [\"$PACKAGE_NAME\"]/g" pyproject.toml
sed -i.bak "s/packages = \[\"long_image_splitter\"\]/packages = [\"$PACKAGE_NAME\"]/g" pyproject.toml

# 更新 Hatch 构建配置中的包路径
sed -i.bak "s|packages = \[\"src/starter_py\"\]|packages = [\"src/$PACKAGE_NAME\"]|g" pyproject.toml
sed -i.bak "s|packages = \[\"src/long_image_splitter\"\]|packages = [\"src/$PACKAGE_NAME\"]|g" pyproject.toml

# 更新 URL
sed -i.bak "s/yourusername\/starter-py/yourusername\/$PROJECT_NAME/g" pyproject.toml
sed -i.bak "s/yourusername\/LongImageSplitter/yourusername\/$PROJECT_NAME/g" pyproject.toml

# 确保有 Hatch 构建配置
if ! grep -q "\[tool.hatch.build.targets.wheel\]" pyproject.toml; then
    echo "添加 Hatch 构建配置..."
    # 在 [build-system] 后添加 Hatch 配置
    sed -i.bak '/^\[build-system\]/,/^build-backend = / {
        /^build-backend = / a\
\
# Hatch build configuration\
[tool.hatch.build.targets.wheel]\
packages = ["src/'$PACKAGE_NAME'"]
    }' pyproject.toml
fi

# 2. 重命名包目录
echo "重命名包目录..."
if [ -d "src/starter_py" ]; then
    mv "src/starter_py" "src/$PACKAGE_NAME"
    echo "已将 src/starter_py 重命名为 src/$PACKAGE_NAME"
elif [ -d "src/long_image_splitter" ]; then
    mv "src/long_image_splitter" "src/$PACKAGE_NAME"
    echo "已将 src/long_image_splitter 重命名为 src/$PACKAGE_NAME"
else
    echo "未找到需要重命名的包目录，创建新的包目录..."
    mkdir -p "src/$PACKAGE_NAME"
    echo "# $PACKAGE_NAME package" > "src/$PACKAGE_NAME/__init__.py"
fi

# 3. 更新包文件中的导入
echo "更新包文件..."
if [ -d "src/$PACKAGE_NAME" ]; then
    find "src/$PACKAGE_NAME" -name "*.py" -exec sed -i.bak "s/starter_py/$PACKAGE_NAME/g" {} \;
    find "src/$PACKAGE_NAME" -name "*.py" -exec sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" {} \;
fi

# 4. 更新测试文件
echo "更新测试文件..."
if [ -d "tests" ]; then
    find tests/ -name "*.py" -exec sed -i.bak "s/starter_py/$PACKAGE_NAME/g" {} \;
    find tests/ -name "*.py" -exec sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" {} \;
fi

# 5. 更新其他文件
echo "更新其他文件..."
if [ -f "main.py" ]; then
    sed -i.bak "s/starter-py/$PROJECT_NAME/g" main.py
    sed -i.bak "s/starter_py/$PACKAGE_NAME/g" main.py
    sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" main.py
fi

if [ -f "app.py" ]; then
    echo "更新 app.py 中的导入语句..."
    sed -i.bak "s/starter_py/$PACKAGE_NAME/g" app.py
    sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" app.py
fi

# if [ -f "README.md" ]; then
#     sed -i.bak "s/Project Name/$PROJECT_NAME/g" README.md
#     sed -i.bak "s/project-name/$PROJECT_NAME/g" README.md
#     sed -i.bak "s/project_name/$PACKAGE_NAME/g" README.md
#     sed -i.bak "s/starter-py/$PROJECT_NAME/g" README.md
#     sed -i.bak "s/starter_py/$PACKAGE_NAME/g" README.md
#     sed -i.bak "s/LongImageSplitter/$PROJECT_NAME/g" README.md
#     sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" README.md
# fi

# 6. 更新 VS Code 配置
echo "更新 VS Code 配置..."
if [ -f ".vscode/settings.json" ]; then
    # 更新 mypy packages 配置
    sed -i.bak "s/starter_py/$PACKAGE_NAME/g" .vscode/settings.json
    sed -i.bak "s/long_image_splitter/$PACKAGE_NAME/g" .vscode/settings.json
fi

# 7. 清理备份文件
echo "清理临时文件..."
find . -name "*.bak" -delete 2>/dev/null || true

# 8. 重新安装项目
echo "重新安装项目..."
if command -v uv >/dev/null 2>&1; then
    if [ -d ".venv" ]; then
        echo "✅ 使用现有虚拟环境"
    fi
    echo "正在同步依赖..."
    if uv sync --extra dev; then
        echo "✅ 项目依赖已同步"
    else
        echo "❌ 依赖同步失败，请检查配置"
        exit 1
    fi
else
    echo "⚠️  uv 未找到，请手动安装依赖"
fi

# 验证构建配置
echo "验证项目构建配置..."
if command -v uv >/dev/null 2>&1; then
    if uv build --wheel >/dev/null 2>&1; then
        echo "✅ 项目构建配置正确"
    else
        echo "❌ 项目构建配置有问题，请检查 pyproject.toml"
        echo "确保以下配置存在："
        echo "  [tool.hatch.build.targets.wheel]"
        echo "  packages = [\"src/$PACKAGE_NAME\"]"
    fi
fi

# 9. 初始化 Git 仓库
echo "初始化 Git 仓库..."
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git 仓库已初始化"
else
    echo "📝 Git 仓库已存在"
fi

# 10. 安装 pre-commit hooks
echo "安装 pre-commit hooks..."
if command -v uv >/dev/null 2>&1; then
    if uv run pre-commit install >/dev/null 2>&1; then
        echo "✅ Pre-commit hooks 已安装"
    else
        echo "⚠️  Pre-commit hooks 安装失败，可能需要手动安装"
    fi
else
    echo "⚠️  uv 未找到，跳过 pre-commit hooks 安装"
fi

# 11. 创建初始提交
echo "创建初始提交..."
git add .
if git commit -m "Initial commit: Initialize $PROJECT_NAME project" >/dev/null 2>&1; then
    echo "✅ 初始提交已创建"
else
    echo "📝 初始提交已存在或无变更"
fi

echo ""
echo "🎉 项目初始化完成！"
echo "项目名称: $PROJECT_NAME"
echo "包名称: $PACKAGE_NAME"
echo ""
echo "📝 注意事项："
echo "  请手动更新 pyproject.toml 中的以下信息："
echo "  - 作者信息 (authors)"
echo "  - GitHub URL 中的 'yourusername'"
echo "  - 项目描述 (description)"
echo ""
echo "下一步："
echo "  make web    # 启动 Web 演示"
echo "  make lint   # 代码格式化和检查"
echo "  make test   # 运行测试"
echo "  make help   # 查看所有可用命令"

# 删除初始化脚本
rm -- "$0"
