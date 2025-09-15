"""Simple example demonstrating the add function."""

import logging

from starter_py import add

# Configure logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


def main() -> None:
    """Main function to demonstrate the add function."""
    logger.info("Hello from starter-py!")

    # Demonstrate the add function
    result = add(2.0, 3.0)
    logger.info("2.0 + 3.0 = %s", result)

    # More examples
    logger.info("10.5 + 5.5 = %s", add(10.5, 5.5))
    logger.info("-1.0 + 1.0 = %s", add(-1.0, 1.0))


if __name__ == "__main__":
    main()
