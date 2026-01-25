# 1. Setup Paths
# $PSScriptRoot is /scripts. $RepoRoot is the base folder.
$RepoRoot = Split-Path -Parent $PSScriptRoot
# $ConfigDir points to /configs where your actual files live
$ConfigDir = Join-Path $RepoRoot "configs"

Write-Host "Detected Repo Root: $RepoRoot" -ForegroundColor Cyan
Write-Host "Looking for configs in: $ConfigDir" -ForegroundColor Cyan

# 2. Define your mappings
# "Name_In_Configs_Folder" = "Target_Path_On_System"
$Mappings = @{
    "wezterm" = "$HOME\.config\wezterm"
    "nvim"    = "$env:LOCALAPPDATA\nvim"
}

# 3. Check for Admin Rights
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Running without Admin. This only works if 'Developer Mode' is enabled in Windows Settings."
}

# 4. Process Mappings
foreach ($entry in $Mappings.GetEnumerator()) {
    $relativePath = $entry.Key
    $targetPath = $entry.Value
    
    # Point to repo/configs/folder_name
    $sourcePath = Join-Path $ConfigDir $relativePath

    Write-Host "`nProcessing: $relativePath" -ForegroundColor Yellow

    # GUARD 1: Source exists?
    if (!(Test-Path $sourcePath)) {
        Write-Warning "  [!] Source not found in repo: $sourcePath. Skipping..."
        continue
    }

    # GUARD 2: Target directory exists?
    $targetDir = Split-Path $targetPath
    if (!(Test-Path $targetDir)) {
        Write-Host "  [+] Creating directory: $targetDir"
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    # GUARD 3: Handle existing files/folders
    if (Test-Path $targetPath) {
        $item = Get-Item $targetPath
        if ($item.Attributes -match "ReparsePoint") {
            Write-Host "  [-] Existing symlink found. Removing old link..."
            Remove-Item $targetPath -Recurse -Force
        }
        else {
            Write-Host "  [!] Real file/folder exists. Backing up to .bak" -ForegroundColor Gray
            $backupPath = "$targetPath.bak"
            if (Test-Path $backupPath) { Remove-Item $backupPath -Recurse -Force }
            Move-Item $targetPath $backupPath
        }
    }

    # 5. Create the Symlink
    try {
        # This handles both files and folders automatically
        New-Item -ItemType SymbolicLink -Path $targetPath -Target $sourcePath -ErrorAction Stop | Out-Null
        Write-Host "  [OK] Linked: $sourcePath -> $targetPath" -ForegroundColor Green
    }
    catch {
        Write-Error "  [X] Failed to link: $($_.Exception.Message)"
    }
}

Write-Host "`nFinished! Your environment is now linked." -ForegroundColor Green