"""Streamlit web application demonstrating the add function."""

import streamlit as st

from src.starter_py.math import add


def main() -> None:
    """Main function for the Streamlit app."""
    # Page configuration
    st.set_page_config(
        page_title="Math Operations Demo",
        page_icon="🧮",
        layout="centered",
        initial_sidebar_state="collapsed",
    )

    # Header
    st.title("🧮 Math Operations Demo")
    st.markdown(
        """
        Welcome to the **Math Operations Demo**! This application demonstrates
        the `add` function from our math module in an interactive way.
        """
    )
    st.markdown("---")

    # Main calculator section
    st.header("🔢 Addition Calculator")
    st.markdown("Enter two numbers below to see the addition in action:")

    # Input section with two columns
    col1, col2 = st.columns(2)

    with col1:
        number_a = st.number_input(
            "First Number (a)",
            value=0.0,
            step=0.1,
            format="%.3f",
            help="Enter the first number to add",
        )

    with col2:
        number_b = st.number_input(
            "Second Number (b)",
            value=0.0,
            step=0.1,
            format="%.3f",
            help="Enter the second number to add",
        )

    # Calculate button and result
    if st.button("🔥 Calculate", type="primary", use_container_width=True):
        result = add(number_a, number_b)

        # Display result with styling
        st.markdown("### 🎯 Result")
        st.success(f"**{number_a} + {number_b} = {result}**")

        # Show the code that was executed
        st.markdown("#### 💻 Code Executed")
        st.code(
            f"""from starter_py.math import add

# Function call
result = add({number_a}, {number_b})
print(f"Result: {result}")""",
            language="python",
        )

    # Examples section
    st.markdown("---")
    st.header("💡 Quick Examples")

    examples: list[tuple[float, float, str]] = [
        (2, 3, "Simple addition"),
        (-5, 8, "Negative + positive"),
        (0.1, 0.2, "Decimal precision"),
        (100, -50, "Large numbers"),
    ]

    # Create example buttons
    for i, (a, b, description) in enumerate(examples):
        if st.button(f"{description}: {a} + {b}", key=f"example_{i}"):
            result = add(a, b)
            st.info(f"Result: {a} + {b} = {result}")

    # Function documentation
    st.markdown("---")
    st.header("📚 Function Documentation")

    with st.expander("📖 View add() function details", expanded=False):
        st.markdown(
            """
        **Function Signature:**
        ```python
        def add(a: float, b: float) -> float
        ```

        **Parameters:**
        - `a` (float): First number to add
        - `b` (float): Second number to add

        **Returns:**
        - float: Sum of a and b

        **Examples:**
        ```python
        >>> from starter_py.math import add
        >>> add(2, 3)
        5.0
        >>> add(-1, 1)
        0.0
        ```
        """
        )

    # Footer
    st.markdown("---")
    st.markdown(
        """
        <div style='text-align: center; color: #666; font-size: 0.9em;'>
            🚀 Built with ❤️ using <strong>Streamlit</strong> and <strong>Python</strong>
        </div>
        """,
        unsafe_allow_html=True,
    )


if __name__ == "__main__":
    main()
