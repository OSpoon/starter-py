"""Tests for math functionality."""

import pytest
from pytest import approx

from starter_py.math import add


class TestAdd:
    """Test cases for the add function."""

    def test_add_positive_numbers(self) -> None:
        """Test addition of positive numbers."""
        result = add(2.0, 3.0)
        assert result == 5.0

    def test_add_negative_numbers(self) -> None:
        """Test addition of negative numbers."""
        result = add(-2.0, -3.0)
        assert result == -5.0

    def test_add_mixed_numbers(self) -> None:
        """Test addition of positive and negative numbers."""
        result = add(-2.0, 3.0)
        assert result == 1.0

    def test_add_zero(self) -> None:
        """Test addition with zero."""
        result = add(5.0, 0.0)
        assert result == 5.0

    def test_add_floating_point(self) -> None:
        """Test addition of floating point numbers."""
        result = add(0.1, 0.2)
        assert result == approx(0.3)

    def test_add_large_numbers(self) -> None:
        """Test addition of large numbers."""
        result = add(1e10, 1e10)
        assert result == 2e10

    @pytest.mark.parametrize(
        "a,b,expected",
        [
            (0, 0, 0),
            (1, 1, 2),
            (-1, 1, 0),
            (100, 200, 300),
            (1.5, 2.5, 4.0),
        ],
    )
    def test_add_parametrized(self, a: float, b: float, expected: float) -> None:
        """Test addition with various parameter combinations."""
        result = add(a, b)
        assert result == expected
