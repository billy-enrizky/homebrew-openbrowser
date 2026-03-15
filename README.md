# Homebrew Tap for OpenBrowser

Homebrew formulae for [OpenBrowser](https://github.com/billy-enrizky/openbrowser-ai) -- AI-powered browser automation using CodeAgent and CDP.

## Installation

```bash
brew tap billy-enrizky/openbrowser
brew install openbrowser-ai
```

## Usage

```bash
# MCP server mode (for Claude Code, Cursor, etc.)
openbrowser --mcp

# CLI daemon mode
openbrowser -c "await navigate('https://example.com')"

# Daemon management
openbrowser daemon start
openbrowser daemon status
```

## Updating

```bash
brew update
brew upgrade openbrowser-ai
```

## Links

- [Documentation](https://docs.openbrowser.me)
- [GitHub](https://github.com/billy-enrizky/openbrowser-ai)
- [PyPI](https://pypi.org/project/openbrowser-ai/)
