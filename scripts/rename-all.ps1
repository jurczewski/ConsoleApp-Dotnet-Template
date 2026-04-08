function Rename-FilenamesAndDirectoryAndContent {
    param (
        [string]$NewPhrase
    )

    # Get the current directory
    $Directory = Get-Location

    # Get all files and directories in the current directory and subdirectories
    $items = Get-ChildItem -Path $Directory -Recurse | Where-Object {
        -not $_.PSIsContainer -and
        $_.Name -notlike "README.md" -and
        $_.Name -notlike "rename-all.ps1"
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

    # Get all directories in the current directory and subdirectories
    $directories = Get-ChildItem -Path $Directory -Recurse | Where-Object {
        $_.PSIsContainer -and
        $_.Name -notlike "README.md" -and
        $_.Name -notlike "rename-all.ps1"
    }

    # Rename directories
    foreach ($dir in $directories) {
        if ($dir.Name -like "*ProjectName*") {
            $newName = $dir.Name -replace "ProjectName", $NewPhrase
            $newPath = Join-Path -Path $dir.Parent.FullName -ChildPath $newName

            Rename-Item -Path $dir.FullName -NewName $newName -Force
            Write-Host "Renamed directory '$($dir.FullName)' to '$($newPath)'"
        }
    }

    # Rename files (already handled above in $items)

    # Notify user about completion
    Write-Host "Rename operation completed."
}

# Prompt the user for the new phrase
$newPhrase = Read-Host "Enter the new phrase to replace 'ProjectName'"

# Call the function to replace filenames, directory names, and file content
Rename-FilenamesAndDirectoryAndContent -NewPhrase $newPhrase
