$ErrorActionPreference = "Stop"

$RepoUrl = if ($env:SCEPTIC_NVIM_REPO) { $env:SCEPTIC_NVIM_REPO } else { "https://github.com/SCEPTICG/SCEPTIC-NVIM.git" }
$Branch = if ($env:SCEPTIC_NVIM_BRANCH) { $env:SCEPTIC_NVIM_BRANCH } else { "main" }
$ConfigHome = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME "AppData\Local" }
$TargetDir = Join-Path $ConfigHome "nvim"
$TempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("sceptic-nvim-" + [System.Guid]::NewGuid().ToString("N"))
$RepoDir = Join-Path $TempRoot "repo"

try {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "git no esta instalado o no esta en PATH."
    }

    New-Item -ItemType Directory -Force -Path $TempRoot | Out-Null

    if (Test-Path -LiteralPath $TargetDir) {
        $BackupDir = "$TargetDir.backup.$(Get-Date -Format yyyyMMddHHmmss)"
        Write-Host "Config existente detectada. Backup: $BackupDir"
        Move-Item -LiteralPath $TargetDir -Destination $BackupDir
    }

    Write-Host "Clonando SCEPTIC-NVIM desde $RepoUrl ($Branch)..."
    git clone --depth 1 --branch $Branch $RepoUrl $RepoDir

    Copy-Item -Recurse -Path (Join-Path $RepoDir "nvim") -Destination $TargetDir

    Write-Host "SCEPTIC-NVIM instalado en: $TargetDir"
    Write-Host "Abre Neovim y ejecuta :Lazy sync, :Mason y :checkhealth."
}
finally {
    if (Test-Path -LiteralPath $TempRoot) {
        Remove-Item -LiteralPath $TempRoot -Recurse -Force
    }
}
