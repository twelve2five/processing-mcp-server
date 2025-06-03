# Processing MCP Server

🎨 **Create visual art and games with AI** - An MCP (Model Context Protocol) server that enables AI assistants to create and run Processing sketches directly through natural language commands.

⭐ **Give us a star if you find this useful!**

## 🎥 Demo Video

**[Watch the demo video here - See it in action!](https://www.loom.com/share/24a238aadb1c44acbf10fac17cddfe25)**

## 🚀 Quick Setup

1. **Clone this repository:**
   ```bash
   git clone https://github.com/twelve2five/processing-mcp-server.git
   cd processing-mcp-server
   ```

2. **Install dependencies:**
   ```bash
   uv pip install fastmcp
   # or
   pip install fastmcp
   ```

3. **Configure Claude Desktop** (see Configuration section below)

4. **Restart Claude and start creating!**

## Features

- 🚀 Create and run Processing sketches from AI conversations
- 💾 Automatically saves sketches with timestamps
- ⚙️ Configurable Processing executable path and save location
- 🤖 Simple tool interface for AI assistants
- 🎮 Includes 6 ready-to-run demos (particles, 3D art, games, and more!)

## Installation

### Prerequisites

- Python 3.8+
- [Processing](https://processing.org/download) installed on your system
- `uv` package manager (or use pip)
- Claude Desktop app

### Step 1: Clone the Repository

```bash
git clone https://github.com/twelve2five/processing-mcp-server.git
cd processing-mcp-server
```

### Step 2: Install Dependencies

#### Install via uv

```bash
uv pip install fastmcp
```

#### Install via pip

```bash
pip install fastmcp
```

### Step 3: Configure Claude Desktop

See the Configuration section below to add the server to your Claude Desktop config.

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
        "C:\\path\\to\\processing-mcp-server\\processing_mcp_server.py"
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
        "/path/to/processing-mcp-server/processing_mcp_server.py"
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
        "/path/to/processing-mcp-server/processing_mcp_server.py"
      ],
      "env": {
        "PROCESSING_PATH": "/usr/bin/processing",
        "PROCESSING_SAVE_LOCATION": "~/Documents/Processing/sketches"
      }
    }
  }
}
```

**Note:** Replace `/path/to/processing-mcp-server/` with the actual path where you cloned the repository.

### 3. Restart Claude Desktop

After updating the configuration file, restart Claude Desktop for the changes to take effect.

## Usage Examples

Once configured, you can ask your AI assistant to:

### 🎯 Simple Animations
- "Create a Processing sketch that draws a bouncing ball"
- "Make a colorful spiral animation"
- "Draw a clock that shows the current time"

### ✨ Particle Effects
- "Create a particle system that follows my mouse"
- "Make fireworks that explode when I click"
- "Generate a starfield simulation"

### 🎮 Games
- "Build a Snake game"
- "Create a Pong clone"
- "Make a simple maze game"

### 🎨 Generative Art
- "Create a generative art piece with flowing waves"
- "Make a 3D rotating geometric shape"
- "Generate the Matrix digital rain effect"

## Included Examples

Check out the `/examples` folder for ready-to-run demos:

1. **bouncing_ball.pde** - Classic animation with trail effects
2. **particle_system.pde** - Interactive particles following your mouse
3. **3d_geometric_art.pde** - Mesmerizing 3D shapes with rainbow colors
4. **matrix_rain.pde** - The iconic Matrix digital rain effect
5. **wave_art.pde** - Beautiful animated wave patterns
6. **snake_game.pde** - Fully playable Snake game

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

### Server not showing up in Claude

Make sure to restart Claude Desktop after updating the configuration file.

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
