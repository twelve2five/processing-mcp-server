import subprocess
import os
import time
import json
from mcp.server.fastmcp import FastMCP

# Initialize FastMCP server
mcp = FastMCP("processing_mcp_server")

# Default configuration
DEFAULT_CONFIG = {
    "processing_path": "processing",  # Will try to use system PATH
    "save_location": os.path.expanduser("~/Documents/Processing/sketches")
}

# Load configuration from environment or use defaults
def load_config():
    config = DEFAULT_CONFIG.copy()
    
    # Check for environment variables
    if "PROCESSING_PATH" in os.environ:
        config["processing_path"] = os.environ["PROCESSING_PATH"]
    
    if "PROCESSING_SAVE_LOCATION" in os.environ:
        config["save_location"] = os.environ["PROCESSING_SAVE_LOCATION"]
    
    # Ensure save location exists
    os.makedirs(config["save_location"], exist_ok=True)
    
    return config

# Load configuration on startup
config = load_config()

@mcp.tool()
def run_processing_java_cli(
    java_code: str,
    processing_path: str = None,
    save_location: str = None
):
    """
    Run Java Processing sketch using CLI and save in specified location
    
    Args:
        java_code: The Processing sketch code to run
        processing_path: Path to Processing executable (optional, uses config default)
        save_location: Directory to save sketches (optional, uses config default)
    
    Returns:
        Dict with status, message, and sketch location
    """
    
    # Use provided paths or fall back to config
    processing_path = processing_path or config["processing_path"]
    save_location = save_location or config["save_location"]
    
    # Create sketch folder in the specified location
    sketch_name = f"sketch_{int(time.time())}"
    sketch_folder = os.path.join(save_location, sketch_name)
    os.makedirs(sketch_folder, exist_ok=True)
    
    # Write Java sketch (.pde file)
    pde_file = os.path.join(sketch_folder, f"{sketch_name}.pde")
    with open(pde_file, 'w', encoding='utf-8') as f:
        f.write(java_code)
    
    # Launch using CLI without waiting
    try:
        process = subprocess.Popen([
            processing_path,
            "cli",
            f"--sketch={sketch_folder}",
            "--run"
        ], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        
        # Quick check if process started successfully
        time.sleep(0.1)  # Brief pause to let process initialize
        if process.poll() is not None:
            # Process ended immediately, likely an error
            stdout, stderr = process.communicate()
            return {
                'status': 'error',
                'message': f'Failed to launch Processing: {stderr or stdout}',
                'sketch_folder': sketch_folder
            }
        
        print(f"Sketch saved at: {sketch_folder}")
        
        return {
            'status': 'success',
            'message': 'Sketch launched successfully! Please wait 10-60 seconds for Processing to compile and display your sketch.',
            'sketch_folder': sketch_folder,
            'note': 'The sketch window will appear separately. Close it manually when done.'
        }
        
    except FileNotFoundError:
        return {
            'status': 'error',
            'message': f'Processing executable not found at: {processing_path}. Please check your configuration.',
            'sketch_folder': sketch_folder
        }
    except Exception as e:
        return {
            'status': 'error',
            'message': f'Error launching Processing: {str(e)}',
            'sketch_folder': sketch_folder
        }

# Provide a tool to get current configuration
@mcp.tool()
def get_processing_config():
    """Get current Processing MCP server configuration"""
    return {
        'processing_path': config['processing_path'],
        'save_location': config['save_location'],
        'info': 'Set PROCESSING_PATH and PROCESSING_SAVE_LOCATION environment variables to override defaults'
    }

if __name__ == "__main__":
    # Print configuration on startup
    print(f"Processing MCP Server starting with config:")
    print(f"  Processing Path: {config['processing_path']}")
    print(f"  Save Location: {config['save_location']}")
    
    # Initialize and run the server
    mcp.run(transport='stdio')