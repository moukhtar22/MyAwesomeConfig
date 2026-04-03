# Contributing to MyAwesomeConfig

Thank you for considering contributing to MyAwesomeConfig! Please read this document to understand how you can contribute effectively.

## How to Contribute

### Reporting Issues
- Use the GitHub issue tracker to report bugs or request features
- Please include as much detail as possible:
  - Steps to reproduce the issue
  - Expected vs actual behavior
  - Screenshots if applicable
  - Your AwesomeWM version and system information

### Submitting Changes
1. Fork the repository
2. Create a new branch for your feature or bugfix
3. Make your changes
4. Ensure your code follows the existing style guidelines
5. Test your changes thoroughly
6. Submit a pull request with a clear description of your changes

## Code Style Guidelines

### Lua Formatting
- Use 4 spaces for indentation (no tabs)
- Limit line length to 120 characters where possible
- Use descriptive variable and function names
- Comment complex logic or non-obvious implementations

### File Organization
- Place new widgets in the `widget/` directory
- Add new themes to the `themes/` directory
- Update configuration files in `configuration/` as needed
- Add helper functions to `helpers.lua` if they're broadly useful

### Commit Messages
- Use clear, descriptive commit messages
- Reference issue numbers when applicable
- Follow the format: `type(scope): description`

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/MyAwesomeConfig.git
   ```

2. Install dependencies (see README.md for complete list)

3. Follow the installation instructions in README.md

4. Test your changes by reloading AwesomeWM:
   ```bash
   # Press Mod+Shift+r or run:
   awesome.restart()
   ```

## Questions?

If you have any questions, feel free to open an issue or contact the maintainers.

Happy coding!