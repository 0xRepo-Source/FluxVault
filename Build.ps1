# FluxVault Build Script For Windows

Write-Host "Building FluxVault components..." -ForegroundColor Gray

# Build FluxVault Server
Write-Host "Building FluxVault Server..." -ForegroundColor Yellow
go build -o Bin/FluxVaultServer.exe ./cmd/server/main.go
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to build FluxVault Server." -ForegroundColor Red
    exit $LASTEXITCODE
}

# Build FluxVault Client
Write-Host "Building FluxVault Client..." -ForegroundColor Yellow
go build -o Bin/FluxVaultClient.exe ./cmd/client/main.go
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to build FluxVault Client." -ForegroundColor Red
    exit $LASTEXITCODE
}

# Build FluxVault Admin Tool
Write-Host "Building FluxVault Admin Tool..." -ForegroundColor Yellow
go build -o Bin/FluxVaultAdmin.exe ./cmd/admin/main.go
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to build FluxVault Admin Tool." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "Build completed successfully!" -ForegroundColor Green
