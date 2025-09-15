# Copilot Instructions for starter-py

This is a modern Python project template using uv for dependency management and featuring a Streamlit web demo.

## Project Architecture

- **Core Package**: `src/starter_py/` - Main Python package with typed interfaces (`py.typed` marker)
- **Web Demo**: `app.py` - Streamlit application demonstrating package functionality
- **Tests**: `tests/` - Comprehensive test suite using pytest with parametrized tests
- **Scripts**: `scripts/init.sh` - Project initialization and template customization

## Key Development Patterns

### Package Structure Convention

- Main package in `src/` layout with `py.typed` for type checking
- Explicit `__all__` exports in `__init__.py`
- Docstrings with Args/Returns/Examples format (supports doctests)

### Code Style & Type Constraints

#### Strict Type Annotations (MyPy Strict Mode)

```python
# ALL functions must have complete type annotations
def add(a: float, b: float) -> float:  # ✅ Correct
    """Add two numbers."""
    return a + b

def bad_function(a, b):  # ❌ Will fail mypy strict mode
    return a + b

# Use type annotations for complex types
examples: list[tuple[float, float, str]] = [
    (2, 3, "Simple addition"),
    (-5, 8, "Negative + positive"),
]
```

#### Ruff Code Style Requirements

```python
# Line length: 88 characters maximum
# Quote style: Double quotes preferred
message = "This is the preferred quote style"

# Import organization (automatic with ruff)
from collections.abc import Sequence
from pathlib import Path

import streamlit as st
from pytest import approx

from starter_py.math import add  # Local imports last

# Function naming: snake_case, descriptive
def calculate_total_sum(values: list[float]) -> float:
    """Calculate sum with descriptive name."""
    return sum(values)
```

#### Enforced Linting Rules

- **Security (S)**: No hardcoded secrets, safe eval usage
- **Naming (N)**: Consistent variable/function naming conventions
- **Imports (I)**: Sorted imports, no unused imports
- **Builtins (A)**: No shadowing of built-in names
- **Simplifications (SIM)**: Use simplified code constructs
- **Performance (PIE)**: Avoid performance antipatterns

### Testing Patterns

```python
# Use pytest.approx for floating point comparisons
assert result == approx(0.3)

# Parametrized tests for comprehensive coverage
@pytest.mark.parametrize("a,b,expected", [(0, 0, 0), (1, 1, 2)])
def test_add_parametrized(self, a: float, b: float, expected: float) -> None:
    """Test with typed parameters - note the complete type annotations."""
    result = add(a, b)
    assert result == expected

# Test class organization
class TestAdd:
    """Group related tests in classes."""

    def test_specific_case(self) -> None:  # Return type required
        """Each test method needs return type annotation."""
        assert add(1.0, 2.0) == 3.0
```

## Essential Commands (Use These, Not Direct Tools)

```bash
# Primary development workflow
make init NAME=project-name    # Initialize new project from template
make web                      # Start Streamlit demo at localhost:8501
make lint                     # Run ruff format + ruff check --fix + mypy
make test                     # Run pytest with xdist parallel execution
make build                    # Build package with hatchling
make clean                    # Remove all cache directories

# Never use: pip, python -m, direct pytest/ruff commands
# Always use: uv run <command> or make targets
```

## Virtual Environment Management

**IMPORTANT**: All `uv run` commands and `make` targets automatically use the project's virtual environment (`.venv/`), **NOT your base/conda environment**:

````bash
# These commands are SAFE - they use project .venv automatically:
make lint                     # Uses .venv/bin/python
make test                     # Uses .venv/bin/python
make web                      # Uses .venv/bin/python
uv run python script.py       # Uses .venv/bin/python
uv run pytest                 # Uses .venv/bin/pytest

# Verification:
uv run which python           # Shows: /path/to/project/.venv/bin/python
which python                  # Shows: /path/to/base/environment/python

# Dependencies are isolated to project .venv:
uv add package-name           # Installs to .venv only
uv sync --extra dev           # Syncs to .venv only
```## Project Initialization Workflow

The `make init` command transforms this template:

1. Updates `pyproject.toml` project name and package references
2. Renames `src/starter_py/` to `src/{new_package_name}/`
3. Updates all import statements across source and test files
4. Configures MyPy and Hatch build paths for new package name

## Tool Configuration Details

- **uv**: Primary dependency manager (replaces pip/poetry), uses `uv.lock`
  - **Automatic virtual environment**: `uv run` always uses `.venv/`, never base environment
  - Project dependencies isolated in `.venv/` directory
  - No need to manually activate/deactivate virtual environments
- **ruff**: Formatter + linter with strict rule set targeting Python 3.12+
  - Line length: 88 characters
  - Double quotes, space indentation
  - Enabled rules: E,W,F,I,B,C4,UP,SIM,RUF,S,N,A,ERA,PIE,Q,RET,T20
  - Tests exempt from security checks (S101 for assertions)
- **mypy**: Strict mode enabled for `src/`, relaxed for `tests/`
  - Requires complete type annotations on all functions
  - `py.typed` marker enables package type checking
- **pytest**: Parallel execution via pytest-xdist, custom markers for test categorization
- **pre-commit**: Enforces formatting and type checking on commits## Lint Fix Workflow

When adding new code that fails lint checks:

```bash
make lint  # Runs: ruff format + ruff check --fix + mypy

# Manual fixes for common issues:
# 1. Add missing type annotations to ALL function parameters and returns
# 2. Import organization will be auto-fixed by ruff
# 3. Line length violations: break long lines at 88 characters
# 4. Use double quotes consistently
# 5. Remove unused variables/imports (ruff auto-fixes)
````

## Integration Points

- Streamlit app imports directly from `src/starter_py/math.py`
- CI uses uv for dependency management and runs full lint/test suite
- Template system allows easy project customization via init script
- Type checking configured for source code strict mode, relaxed for tests

## When Adding Features

1. Add core functionality to `src/starter_py/` with full type hints
2. Export new functions in `__init__.py` `__all__` list
3. Add comprehensive tests in `tests/` with parametrized cases
4. Update Streamlit demo in `app.py` to showcase new features
5. Run `make lint` before committing (enforced by pre-commit hooks)
