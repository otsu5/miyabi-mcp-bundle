#!/bin/bash
# generate-mcp.sh - Generate MCP server definition from paper and code analysis
# Version: 1.0.0
# Part of: Paper2Agent Skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_DIR="${MIYABI_PAPER2AGENT_CACHE_DIR:-$HOME/.miyabi/paper2agent}"
MCP_OUTPUT_DIR="${MIYABI_MCP_SERVERS_DIR:-.claude/mcp-servers/paper2agent}"

mkdir -p "$MCP_OUTPUT_DIR"

# ============================================================
# Functions
# ============================================================

log() {
  echo "[$(date -Iseconds)] $*" >&2
}

load_paper_analysis() {
  local analysis_file="$1"

  if [ ! -f "$analysis_file" ]; then
    log "ERROR: Paper analysis file not found: $analysis_file"
    exit 1
  fi

  log "Loading paper analysis from $analysis_file"
  cat "$analysis_file"
}

load_code_analysis() {
  local analysis_file="$1"

  if [ ! -f "$analysis_file" ]; then
    log "ERROR: Code analysis file not found: $analysis_file"
    exit 1
  fi

  log "Loading code analysis from $analysis_file"
  cat "$analysis_file"
}

generate_mcp_name() {
  local paper_title="$1"

  # Convert title to kebab-case
  echo "$paper_title" | \
    tr '[:upper:]' '[:lower:]' | \
    sed 's/[^a-z0-9]/-/g' | \
    sed 's/--*/-/g' | \
    sed 's/^-//' | \
    sed 's/-$//' | \
    cut -c1-50
}

generate_tool_schema() {
  local func_name="$1"
  local func_sig="$2"
  local language="$3"

  # Extract parameters from signature (simple parsing)
  local params=$(echo "$func_sig" | grep -o '([^)]*)' | tr -d '()')

  cat <<EOF
    {
      "name": "$func_name",
      "description": "Execute $func_name from paper implementation",
      "inputSchema": {
        "type": "object",
        "properties": {
          "input": {
            "type": "string",
            "description": "Input data for $func_name"
          }
        },
        "required": ["input"]
      }
    }
EOF
}

generate_mcp_server_json() {
  local paper_analysis="$1"
  local code_analysis="$2"
  local output_file="$3"

  log "Generating MCP server definition"

  # Extract metadata
  local paper_title=$(echo "$paper_analysis" | jq -r '.title // "Unknown Paper"')
  local arxiv_id=$(echo "$paper_analysis" | jq -r '.arxiv_id // ""')
  local language=$(echo "$code_analysis" | jq -r '.language // "python"')

  # Generate MCP name
  local mcp_name=$(generate_mcp_name "$paper_title")
  log "MCP server name: paper-$mcp_name"

  # Extract functions from code analysis
  local functions=$(echo "$code_analysis" | jq -c '.sample_functions[]? // empty' 2>/dev/null || echo "")

  # Start JSON output
  cat > "$output_file" <<EOF
{
  "name": "paper-$mcp_name",
  "version": "1.0.0",
  "description": "MCP server generated from: $paper_title",
  "metadata": {
    "arxiv_id": "$arxiv_id",
    "language": "$language",
    "generated_at": "$(date -Iseconds)",
    "generator": "miyabi-paper2agent"
  },
  "command": "python",
  "args": ["-m", "paper_${mcp_name//-/_}.mcp_server"],
  "tools": [
EOF

  # Add tools for each function
  local first=true
  if [ -n "$functions" ]; then
    echo "$functions" | while IFS= read -r func; do
      local func_name=$(echo "$func" | jq -r '.name // .signature' | cut -d'(' -f1 | xargs)
      local func_sig=$(echo "$func" | jq -r '.signature // .name')

      if [ "$first" = true ]; then
        first=false
      else
        echo "," >> "$output_file"
      fi

      generate_tool_schema "$func_name" "$func_sig" "$language" >> "$output_file"
    done
  else
    # No functions found - generate generic tool
    cat >> "$output_file" <<TOOLEOF
    {
      "name": "execute",
      "description": "Execute paper implementation",
      "inputSchema": {
        "type": "object",
        "properties": {
          "query": {
            "type": "string",
            "description": "Input query"
          }
        },
        "required": ["query"]
      }
    }
TOOLEOF
  fi

  # Close JSON
  cat >> "$output_file" <<EOF

  ]
}
EOF

  log "MCP server definition saved to $output_file"
}

generate_mcp_server_python() {
  local mcp_name="$1"
  local code_analysis="$2"
  local output_dir="$3"

  log "Generating Python MCP server implementation"

  local server_name="paper_${mcp_name//-/_}"
  local server_dir="$output_dir/$server_name"
  mkdir -p "$server_dir"

  # Generate mcp_server.py
  cat > "$server_dir/mcp_server.py" <<'EOF'
#!/usr/bin/env python3
"""
MCP Server for Paper2Agent
Auto-generated from paper analysis

This server exposes paper implementation as MCP tools.
"""

import asyncio
import importlib
import importlib.util
import json
import os
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

class PaperMCPServer:
    """MCP Server wrapper for paper implementation"""

    def __init__(self, config_path: Optional[str] = None):
        self.name = "paper-implementation"
        self.config_path = config_path or os.environ.get(
            "PAPER2AGENT_MCP_CONFIG",
            str(Path(__file__).parent / "mcp_definition.json")
        )
        self.paper_module = None
        self.tools_cache: Optional[List[Dict]] = None
        self._load_paper_module()

    def _load_paper_module(self) -> None:
        """Load the paper implementation module dynamically"""
        paper_module_path = os.environ.get(
            "PAPER2AGENT_MODULE_PATH",
            str(Path(__file__).parent / "paper_impl.py")
        )

        if not os.path.exists(paper_module_path):
            # Module not yet implemented - will use stub
            self.paper_module = None
            return

        try:
            spec = importlib.util.spec_from_file_location("paper_impl", paper_module_path)
            if spec and spec.loader:
                module = importlib.util.module_from_spec(spec)
                sys.modules["paper_impl"] = module
                spec.loader.exec_module(module)
                self.paper_module = module
        except Exception as e:
            print(f"Warning: Failed to load paper module: {e}", file=sys.stderr)
            self.paper_module = None

    def _load_mcp_definition(self) -> Dict[str, Any]:
        """Load MCP definition from JSON file"""
        if not os.path.exists(self.config_path):
            return {"tools": []}

        try:
            with open(self.config_path, "r") as f:
                return json.load(f)
        except Exception as e:
            print(f"Warning: Failed to load MCP definition: {e}", file=sys.stderr)
            return {"tools": []}

    async def call_tool(self, name: str, arguments: Dict[str, Any]) -> Dict[str, Any]:
        """
        Execute a tool call.

        Args:
            name: Tool name
            arguments: Tool arguments

        Returns:
            Tool execution result
        """
        # Check if paper module is loaded
        if self.paper_module is None:
            return {
                "success": False,
                "error": "Paper implementation module not loaded",
                "hint": f"Create paper_impl.py with function '{name}' or set PAPER2AGENT_MODULE_PATH"
            }

        # Get the function from the paper module
        func = getattr(self.paper_module, name, None)
        if func is None:
            return {
                "success": False,
                "error": f"Function '{name}' not found in paper implementation",
                "available_functions": [
                    attr for attr in dir(self.paper_module)
                    if callable(getattr(self.paper_module, attr)) and not attr.startswith("_")
                ]
            }

        # Execute the function
        try:
            if asyncio.iscoroutinefunction(func):
                result = await func(**arguments)
            else:
                result = func(**arguments)

            return {
                "success": True,
                "result": result
            }
        except TypeError as e:
            return {
                "success": False,
                "error": f"Invalid arguments for '{name}': {e}",
                "provided_args": list(arguments.keys())
            }
        except Exception as e:
            return {
                "success": False,
                "error": f"Execution failed: {e}",
                "exception_type": type(e).__name__
            }

    async def list_tools(self) -> List[Dict[str, Any]]:
        """List available tools from MCP definition JSON"""
        if self.tools_cache is not None:
            return self.tools_cache

        # Load from MCP definition JSON
        mcp_def = self._load_mcp_definition()
        tools = mcp_def.get("tools", [])

        if tools:
            self.tools_cache = tools
            return tools

        # Fallback: Auto-discover from paper module
        if self.paper_module:
            discovered_tools = []
            for attr_name in dir(self.paper_module):
                if attr_name.startswith("_"):
                    continue
                attr = getattr(self.paper_module, attr_name)
                if callable(attr):
                    discovered_tools.append({
                        "name": attr_name,
                        "description": attr.__doc__ or f"Execute {attr_name} from paper implementation",
                        "inputSchema": {
                            "type": "object",
                            "properties": {
                                "input": {
                                    "type": "string",
                                    "description": f"Input for {attr_name}"
                                }
                            }
                        }
                    })
            if discovered_tools:
                self.tools_cache = discovered_tools
                return discovered_tools

        # Default fallback tool
        return [
            {
                "name": "execute",
                "description": "Execute paper implementation",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "query": {"type": "string", "description": "Input query"}
                    },
                    "required": ["query"]
                }
            }
        ]

async def main():
    """Main server loop"""
    config_path = sys.argv[1] if len(sys.argv) > 1 else None
    server = PaperMCPServer(config_path)

    # Read stdin for MCP protocol messages
    for line in sys.stdin:
        if not line.strip():
            continue
        try:
            request = json.loads(line)
            method = request.get("method")

            if method == "tools/list":
                tools = await server.list_tools()
                response = {"tools": tools}
            elif method == "tools/call":
                name = request.get("params", {}).get("name")
                arguments = request.get("params", {}).get("arguments", {})
                result = await server.call_tool(name, arguments)
                response = {"result": result}
            elif method == "initialize":
                response = {
                    "protocolVersion": "2024-11-05",
                    "serverInfo": {"name": server.name, "version": "1.0.0"},
                    "capabilities": {"tools": {}}
                }
            else:
                response = {"error": f"Unknown method: {method}"}

            print(json.dumps(response), flush=True)

        except json.JSONDecodeError as e:
            error_response = {"error": f"Invalid JSON: {e}"}
            print(json.dumps(error_response), flush=True)
        except Exception as e:
            error_response = {"error": str(e)}
            print(json.dumps(error_response), flush=True)

if __name__ == "__main__":
    asyncio.run(main())
EOF

  chmod +x "$server_dir/mcp_server.py"

  # Generate requirements.txt
  cat > "$server_dir/requirements.txt" <<EOF
# MCP Server dependencies
# Add paper-specific dependencies here
EOF

  # Generate paper_impl.py template
  cat > "$server_dir/paper_impl.py" <<'PAPEREOF'
#!/usr/bin/env python3
"""
Paper Implementation Module
Auto-generated template - implement your paper's functions here.

This module is dynamically loaded by the MCP server.
Each public function becomes an available tool.
"""

from typing import Any, Dict, List, Optional
import json


# ============================================================
# Example function template
# Replace with actual paper implementation
# ============================================================

def execute(query: str) -> Dict[str, Any]:
    """
    Main execution function for the paper implementation.

    Args:
        query: Input query or data to process

    Returns:
        Processing result
    """
    # TODO: Implement actual paper algorithm here
    return {
        "status": "not_implemented",
        "query": query,
        "message": "Replace this with your paper implementation"
    }


def analyze(input_data: str, options: Optional[Dict] = None) -> Dict[str, Any]:
    """
    Analyze input data using paper methodology.

    Args:
        input_data: Data to analyze
        options: Optional configuration

    Returns:
        Analysis results
    """
    options = options or {}
    # TODO: Implement paper analysis logic
    return {
        "status": "not_implemented",
        "input_length": len(input_data),
        "options": options
    }


def transform(data: str, mode: str = "default") -> Dict[str, Any]:
    """
    Transform data using paper approach.

    Args:
        data: Input data
        mode: Transformation mode

    Returns:
        Transformed data
    """
    # TODO: Implement paper transformation
    return {
        "status": "not_implemented",
        "mode": mode,
        "original_data": data[:100] + "..." if len(data) > 100 else data
    }


# ============================================================
# Add your paper-specific functions below
# ============================================================

# Example: If your paper implements a specific algorithm
#
# def paper_algorithm(input_tensor, hyperparameter=0.5):
#     """
#     Implements the main algorithm from the paper.
#
#     Args:
#         input_tensor: Input data
#         hyperparameter: Algorithm tuning parameter
#
#     Returns:
#         Algorithm output
#     """
#     # Your implementation here
#     pass
PAPEREOF

  chmod +x "$server_dir/paper_impl.py"

  # Copy MCP definition for tool loading
  if [ -f "$output_file" ]; then
    cp "$output_file" "$server_dir/mcp_definition.json"
  fi

  # Generate README
  cat > "$server_dir/README.md" <<EOF
# Paper2Agent MCP Server: $server_name

Auto-generated MCP server from paper analysis.

## Files

| File | Description |
|------|-------------|
| \`mcp_server.py\` | MCP protocol server |
| \`paper_impl.py\` | Paper implementation (edit this!) |
| \`mcp_definition.json\` | Tool definitions |
| \`requirements.txt\` | Python dependencies |

## Installation

\`\`\`bash
pip install -r requirements.txt
\`\`\`

## Usage

### 1. Implement Paper Functions

Edit \`paper_impl.py\` to add your paper's implementation:

\`\`\`python
def my_algorithm(input_data: str, param: float = 0.5):
    \"\"\"Your paper's main algorithm.\"\"\"
    # Implement here
    return {"result": processed_data}
\`\`\`

### 2. Test Server

\`\`\`bash
# Run server
python mcp_server.py

# Test with JSON-RPC
echo '{"method":"tools/list"}' | python mcp_server.py
\`\`\`

### 3. Register in Claude

Add to \`claude_desktop_config.json\`:

\`\`\`json
{
  "mcpServers": {
    "paper-$mcp_name": {
      "command": "python",
      "args": ["$(pwd)/mcp_server.py"]
    }
  }
}
\`\`\`

## Environment Variables

| Variable | Description |
|----------|-------------|
| \`PAPER2AGENT_MODULE_PATH\` | Custom path to paper_impl.py |
| \`PAPER2AGENT_MCP_CONFIG\` | Custom path to mcp_definition.json |

## Development

1. Edit \`paper_impl.py\` with your paper's functions
2. Update \`mcp_definition.json\` tool schemas if needed
3. Add dependencies to \`requirements.txt\`
4. Test with MCP Inspector or Claude Desktop
EOF

  log "Python MCP server generated at $server_dir"
}

# ============================================================
# Main Logic
# ============================================================

usage() {
  cat <<EOF
Usage: $0 --paper-analysis <file> --code-analysis <file> [options]

Generate MCP server definition from paper and code analysis.

Options:
  --paper-analysis <file>   Paper analysis JSON (required)
  --code-analysis <file>    Code analysis JSON (required)
  --output <file>           Output MCP JSON file (default: auto-generated)
  --generate-impl           Generate Python implementation skeleton

Environment:
  MIYABI_PAPER2AGENT_CACHE_DIR   Cache directory (default: ~/.miyabi/paper2agent)
  MIYABI_MCP_SERVERS_DIR         MCP servers directory (default: .claude/mcp-servers/paper2agent)

Examples:
  # Generate MCP definition
  $0 --paper-analysis paper.json --code-analysis code.json

  # Generate with implementation
  $0 --paper-analysis paper.json --code-analysis code.json --generate-impl
EOF
  exit 1
}

main() {
  local paper_analysis_file=""
  local code_analysis_file=""
  local output_file=""
  local generate_impl=false

  # Parse arguments
  while [ $# -gt 0 ]; do
    case "$1" in
      --paper-analysis)
        paper_analysis_file="$2"
        shift 2
        ;;
      --code-analysis)
        code_analysis_file="$2"
        shift 2
        ;;
      --output)
        output_file="$2"
        shift 2
        ;;
      --generate-impl)
        generate_impl=true
        shift
        ;;
      *)
        usage
        ;;
    esac
  done

  if [ -z "$paper_analysis_file" ] || [ -z "$code_analysis_file" ]; then
    log "ERROR: Both --paper-analysis and --code-analysis are required"
    usage
  fi

  # Load analyses
  local paper_analysis=$(load_paper_analysis "$paper_analysis_file")
  local code_analysis=$(load_code_analysis "$code_analysis_file")

  # Generate MCP name
  local paper_title=$(echo "$paper_analysis" | jq -r '.title // "Unknown Paper"')
  local mcp_name=$(generate_mcp_name "$paper_title")

  # Set output file if not specified
  if [ -z "$output_file" ]; then
    output_file="$MCP_OUTPUT_DIR/paper-$mcp_name.json"
  fi

  mkdir -p "$(dirname "$output_file")"

  # Generate MCP server JSON
  generate_mcp_server_json "$paper_analysis" "$code_analysis" "$output_file"

  # Generate implementation if requested
  if [ "$generate_impl" = true ]; then
    generate_mcp_server_python "$mcp_name" "$code_analysis" "$MCP_OUTPUT_DIR"
  fi

  log "✅ MCP generation complete"
  log "Definition: $output_file"

  if [ "$generate_impl" = true ]; then
    log "Implementation: $MCP_OUTPUT_DIR/paper_${mcp_name//-/_}/"
  fi

  # Output final path
  echo "$output_file"
}

# ============================================================
# Entry Point
# ============================================================

if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
  main "$@"
fi
