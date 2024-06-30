# Function to replace "ProjectName" in file and directory names and their content with the given phrase
function Replace-FilenameAndContent {
    param (
        [string]$NewPhrase
    )

    # Get the current directory
    $Directory = Get-Location

    # Get all files and directories in the current directory and subdirectories
    $items = Get-ChildItem -Path $Directory -Recurse

    # First, replace "ProjectName" with the new phrase in file content
    $files = $items | Where-Object { -not $_.PSIsContainer }
    foreach ($file in $files) {
        try {
            $content = Get-Content -Path $file.FullName -ErrorAction Stop
            $newContent = $content -replace "ProjectName", $NewPhrase
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Replaced content in '$($file.Name)'"
        }
        catch {
            Write-Warning "Could not read or write content of '$($file.FullName)'. Skipping content replacement."
        }
    }

    # Then, rename directories and files
    $directories = $items | Where-Object { $_.PSIsContainer } | Sort-Object -Property FullName -Descending
    foreach ($directory in $directories) {
        if ($directory.Name -like "*ProjectName*") {
            $newDirName = $directory.Name -replace "ProjectName", $NewPhrase
            $newDirPath = Join-Path -Path $directory.Parent.FullName -ChildPath $newDirName

            Rename-Item -Path $directory.FullName -NewName $newDirPath
            Write-Host "Renamed directory '$($directory.FullName)' to '$($newDirPath)'"
        }
    }

    foreach ($file in $files) {
        if ($file.Name -like "*ProjectName*") {
            $newFileName = $file.Name -replace "ProjectName", $NewPhrase
            $newFilePath = Join-Path -Path $file.DirectoryName -ChildPath $newFileName

            Rename-Item -Path $file.FullName -NewName $newFilePath
            Write-Host "Renamed file '$($file.FullName)' to '$($newFilePath)'"
        }
    }
}

# Prompt the user for the new phrase
$newPhrase = Read-Host "Enter the new phrase to replace 'ProjectName'"

# Call the function to replace filenames, directory names, and file content
Replace-FilenameAndContent -NewPhrase $newPhrase
