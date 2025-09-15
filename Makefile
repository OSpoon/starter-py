.PHONY: init lint test build clean web help

help: ## Show this help message
	@echo '🚀 Python Project Development Commands'
	@echo ''
	@printf '  \033[36m%-15s\033[0m %s\n' 'init' 'Initialize project and setup environment (Usage: make init NAME=project-name)'
	@printf '  \033[36m%-15s\033[0m %s\n' 'web' 'Run the Streamlit web application'
	@printf '  \033[36m%-15s\033[0m %s\n' 'lint' 'Format and fix code issues'
	@printf '  \033[36m%-15s\033[0m %s\n' 'test' 'Run tests'
	@printf '  \033[36m%-15s\033[0m %s\n' 'build' 'Build package'
	@printf '  \033[36m%-15s\033[0m %s\n' 'clean' 'Clean temporary files'
	@printf '  \033[36m%-15s\033[0m %s\n' 'help' 'Show this help message'

# Initialize project and setup environment
init: ## Initialize project and setup environment
	@if [ -z "$(NAME)" ]; then \
		echo "用法: make init NAME=项目名"; \
		echo "示例: make init NAME=my-awesome-project"; \
		echo "包名将自动转换为: my_awesome_project"; \
		exit 1; \
	fi
	@echo "🔧 Setting up virtual environment..."
	@if ! command -v uv >/dev/null 2>&1; then \
		echo "❌ uv is not installed. Please install it first: pip install uv"; \
		exit 1; \
	fi
	@if [ ! -f "uv.lock" ]; then \
		echo "📦 Creating lock file..."; \
		uv lock; \
	fi
	@echo "🏗️ Installing dependencies..."
	@uv sync --extra dev
	@echo "✅ Virtual environment ready at .venv/"
	@echo "🚀 Initializing project: $(NAME)"
	@PACKAGE_NAME=$$(echo "$(NAME)" | sed 's/-/_/g' | tr '[:upper:]' '[:lower:]'); \
	./scripts/init.sh "$(NAME)" "$$PACKAGE_NAME"

web: ## Run the Streamlit web application
	@echo "🌐 Starting Streamlit web application..."
	@echo "📱 The app will open in your browser at http://localhost:8501"
	@uv run streamlit run app.py

lint: ## Format and fix all code issues
	@echo "🎨 Formatting and fixing all code issues..."
	@uv run ruff format .
	@uv run ruff check --fix .
	@uv run mypy src tests

test: ## Run tests
	@uv run pytest

build: ## Build package
	@echo "🏗️ Building package..."
	@uv build

clean: ## Clean temporary files and caches
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	rm -rf build/ dist/ 2>/dev/null || true
