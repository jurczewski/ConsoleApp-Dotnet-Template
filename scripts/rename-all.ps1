function Rename-FilenamesAndDirectoryAndContent {
    param (
        [string]$NewPhrase
    )

    $Directory = Split-Path -Parent $PSScriptRoot

    # Get all files and directories in the current directory and subdirectories
    $items = Get-ChildItem -Path $Directory -Recurse | Where-Object {
        -not $_.PSIsContainer -and
        $_.Name -notlike "README.md" -and
        $_.Name -notlike "rename-all.ps1" -and
        $_.Name -notlike "rename-all.sh"
    }

    # Replace "ProjectName" with the new phrase in file content
    foreach ($file in $items) {
        try {
            $content = Get-Content -Path $file.FullName -ErrorAction Stop
            $newContent = $content -replace "ProjectName", $NewPhrase
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Replaced content in '$($file.FullName)'"
        }
        catch {
            Write-Warning "Could not read or write content of '$($file.FullName)'. Skipping content replacement."
        }
    }

    # Rename files containing "ProjectName" (before directories, so paths are still valid)
    foreach ($file in $items) {
        if ($file.Name -like "*ProjectName*") {
            $newName = $file.Name -replace "ProjectName", $NewPhrase
            Rename-Item -Path $file.FullName -NewName $newName -Force
            Write-Host "Renamed file '$($file.FullName)' to '$newName'"
        }
    }

    # Rename directories containing "ProjectName" (deepest first)
    $directories = Get-ChildItem -Path $Directory -Recurse | Where-Object {
        $_.PSIsContainer
    } | Sort-Object { $_.FullName.Length } -Descending

    foreach ($dir in $directories) {
        if ($dir.Name -like "*ProjectName*") {
            $newName = $dir.Name -replace "ProjectName", $NewPhrase
            $newPath = Join-Path -Path $dir.Parent.FullName -ChildPath $newName
            Rename-Item -Path $dir.FullName -NewName $newName -Force
            Write-Host "Renamed directory '$($dir.FullName)' to '$($newPath)'"
        }
    }

    # Notify user about completion
    Write-Host "Rename operation completed."
}

# Prompt the user for the new phrase
$newPhrase = Read-Host "Enter the new phrase to replace 'ProjectName'"

if ([string]::IsNullOrWhiteSpace($newPhrase)) {
    Write-Error "Error: phrase cannot be empty."
    exit 1
}

# Call the function to replace filenames, directory names, and file content
Rename-FilenamesAndDirectoryAndContent -NewPhrase $newPhrase
