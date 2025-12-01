# FluxVault

A lightweight, secure file transfer system for local networks with resumable uploads, chunked transfers, and optional authentication.

## Features

- Chunked file transfers with resume capability
- Server-side authentication support using challenge-response tokens
- Persistent session management for interrupted uploads
- Simple HTTP-based protocol
- Cross-platform support (Windows, Linux, macOS)
- Automatic firewall configuration (Windows)
- Directory operations (list, create, delete)

## Components

### Server (`FluxVault-server.exe`)
HTTP server that manages file storage, authentication, and upload sessions.

### Client (`FluxVault.exe`)
Command-line client for uploading, downloading, and managing files.

### Admin (`FluxVaultAdmin.exe`)
Administrative tool for generating authentication tokens.

## Installation

Build all components:
```powershell
.\Build.ps1
```

Executables will be created in the `Bin` directory.

## Quick Start

### Server Setup

1. Start the server:
```
FluxVault-server.exe
```

2. Optional: Configure custom settings in `FluxVault.json`:
```json
{
  "server": {
    "address": "192.168.1.100:8080",
    "storage_dir": "./storage",
    "meta_dir": "./meta",
    "tokens_file": "tokens.json"
  }
}
```

3. Optional: Enable authentication:
```
FluxVaultAdmin.exe
```

### Client Setup

1. Configure the server address:
```
FluxVault.exe -config 192.168.1.100:8080
```

This creates a `FluxVault.json` configuration file in the current directory.

2. If authentication is enabled, add the token to `FluxVault.json`:
```json
{
  "client": {
    "server_url": "http://192.168.1.100:8080",
    "chunk_size": 1048576,
    "token": "your-token-here"
  }
}
```

Or set the environment variable:
```powershell
$env:FluxVault_TOKEN_LITE = "your-token-here"
```
## Environment Variables
- `FluxVault_TOKEN_LITE`: Authentication token for client access. Has to be issues by the server admin via FluxVaultAdmin.exe.
- You can add the .exe to your PATH for easier access and use cmd/powershell `FluxVault ls` from any directory.

## Client Usage

### Upload a file
```
FluxVault.exe put localfile.txt remotefile.txt
```

### Download a file
```
FluxVault.exe get remotefile.txt localfile.txt
```

### List files
```
FluxVault.exe ls
FluxVault.exe ls folder/
```

### Create directory
```
FluxVault.exe mkdir newfolder
```

### Delete file or directory
```
FluxVault.exe rm oldfile.txt
```

## Configuration Files

### Server Configuration (`FluxVault.json`)
```json
{
  "server": {
    "address": "192.168.1.100:8080",
    "storage_dir": "./storage",
    "meta_dir": "./meta",
    "tokens_file": "tokens.json",
    "max_file_size": 1073741824
  }
}
```

### Client Configuration (`FluxVault.json`)
```json
{
  "client": {
    "server_url": "http://192.168.1.100:8080",
    "chunk_size": 1048576,
    "token": ""
  }
}
```
## Configuration.
- `FluxVault.json` is the default configuration file name for both server and client.
- You can specify a different configuration file using the `-config` command line argument.

## Authentication

FluxVault supports challenge-response authentication for secure access control.

1. Generate tokens using the admin tool:
```
FluxVaultAdmin.exe
```

2. Distribute tokens to users securely

3. Users configure tokens in their client configuration or environment variables

## Technical Details

### Upload Process
- Files are split into 1MB chunks by default
- Each chunk is uploaded separately with progress tracking
- Server tracks received chunks for resume capability
- Failed uploads can be resumed from the last successful chunk

### Session Management
- Upload sessions are persisted to disk
- Sessions track received chunks and total file information
- Automatic cleanup on successful completion

### Security
- Network discovery removed for enhanced security
- Manual server configuration required
- Optional token-based authentication
- Challenge-response protocol prevents token replay

## Building from Source

Requirements:
- Go 1.21 or later (https://go.dev/dl/)

Build commands:
```powershell
# Build all components
.\Build.ps1

# Or build individually
go build -o bin/FluxVault-server.exe ./cmd/server
go build -o bin/FluxVault.exe ./cmd/client
go build -o bin/FluxVaultAdmin.exe ./cmd/admin
```

## Contributing

This project is maintained by developers who understand system security and proper code architecture. Pull requests containing AI-generated code or vibe coding patterns will be rejected. We require contributors to have a clear understanding of what they are implementing and why.

Requirements for contributions:
- Demonstrate understanding of the security implications of your changes
- Follow existing code patterns and architecture
- Provide clear technical justification for changes
- No AI-assisted code generation or pattern matching without deep comprehension
- Manual code review and testing required

This project prioritizes security and stability over rapid feature addition. If you do not understand the implications of your changes on the security model, do not submit them.

## License

See LICENSE file for details.