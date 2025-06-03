# Processing MCP Server

An MCP (Model Context Protocol) server that enables AI assistants to create and run Processing sketches directly through natural language commands.

## Features

- Create and run Processing sketches from AI conversations
- Automatically saves sketches with timestamps
- Configurable Processing executable path and save location
- Simple tool interface for AI assistants

## Installation

### Prerequisites

- Python 3.8+
- [Processing](https://processing.org/download) installed on your system
- `uv` package manager (or use pip)

### Install via uv

```bash
uv pip install fastmcp
```

### Install via pip

```bash
pip install fastmcp
```

## Configuration

The server can be configured in two ways:

### 1. Environment Variables

Set these environment variables before running the server:

- `PROCESSING_PATH`: Path to your Processing executable
- `PROCESSING_SAVE_LOCATION`: Directory where sketches will be saved

### 2. Claude Desktop Configuration

Add this to your Claude Desktop config file:

**Windows** (`%APPDATA%\Claude\claude_desktop_config.json`):
```json
{
  "mcpServers": {
    "processing": {
      "command": "uv",
      "args": [
        "run",
        "path/to/processing_mcp_server.py"
      ],
      "env": {
        "PROCESSING_PATH": "C:\\Program Files\\Processing\\Processing.exe",
        "PROCESSING_SAVE_LOCATION": "C:\\Users\\YourUsername\\Documents\\Processing\\sketches"
      }
    }
  }
}
```

**macOS** (`~/Library/Application Support/Claude/claude_desktop_config.json`):
```json
{
  "mcpServers": {
    "processing": {
      "command": "uv",
      "args": [
        "run",
        "path/to/processing_mcp_server.py"
      ],
      "env": {
        "PROCESSING_PATH": "/Applications/Processing.app/Contents/MacOS/Processing",
        "PROCESSING_SAVE_LOCATION": "~/Documents/Processing/sketches"
      }
    }
  }
}
```

**Linux** (`~/.config/Claude/claude_desktop_config.json`):
```json
{
  "mcpServers": {
    "processing": {
      "command": "uv",
      "args": [
        "run",
        "path/to/processing_mcp_server.py"
      ],
      "env": {
        "PROCESSING_PATH": "/usr/bin/processing",
        "PROCESSING_SAVE_LOCATION": "~/Documents/Processing/sketches"
      }
    }
  }
}
```

## Usage

Once configured, you can ask your AI assistant to:

- "Create a Processing sketch that draws a bouncing ball"
- "Make a colorful spiral animation in Processing"
- "Generate a Processing sketch with particle effects"

The AI will use the `run_processing_java_cli` tool to create and launch your sketch.

## Available Tools

### `run_processing_java_cli`

Creates and runs a Processing sketch.

**Parameters:**
- `java_code` (required): The Processing sketch code
- `processing_path` (optional): Override the default Processing executable path
- `save_location` (optional): Override the default save location

### `get_processing_config`

Returns the current server configuration.

## Default Paths

If no configuration is provided, the server uses these defaults:

- **Processing Path**: `processing` (assumes Processing is in your system PATH)
- **Save Location**: `~/Documents/Processing/sketches`

## Troubleshooting

### Processing not found

If you get a "Processing executable not found" error:

1. Ensure Processing is installed
2. Check that the path in your configuration is correct
3. On Windows, use double backslashes (`\\`) in the path
4. On macOS, the path should point to the executable inside the .app bundle

### Permission errors

Make sure the save location directory exists and is writable by your user.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details