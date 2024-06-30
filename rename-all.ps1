# Function to replace "HousingScraper" in file content and filenames with the given phrase
function Replace-FilenameAndContent {
    param (
        [string]$NewPhrase
    )

    # Get the current directory
    $Directory = Get-Location

    # Get all files in the current directory and subdirectories
    $files = Get-ChildItem -Path $Directory -File -Recurse

    foreach ($file in $files) {
        # Replace "HousingScraper" with the new phrase in the file content
        try {
            $content = Get-Content -Path $file.FullName -ErrorAction Stop
            $newContent = $content -replace "HousingScraper", $NewPhrase
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Replaced content in '$($file.Name)'"
        }
        catch {
            Write-Warning "Could not read or write content of '$($file.FullName)'. Skipping content replacement."
        }
    }

    # Renaming files after content replacement
    foreach ($file in $files) {
        # Check if the filename contains "HousingScraper"
        if ($file.Name -like "*HousingScraper*") {
            # Replace "HousingScraper" with the new phrase in the filename
            $newName = $file.Name -replace "HousingScraper", $NewPhrase

            # Get the full path of the new filename
            $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName

            # Rename the file
            Rename-Item -Path $file.FullName -NewName $newPath
            Write-Host "Renamed '$($file.Name)' to '$($newName)'"
        }
    }
}

# Prompt the user for the new phrase
$newPhrase = Read-Host "Enter the new phrase to replace 'HousingScraper'"

# Call the function to replace filenames and file content
Replace-FilenameAndContent -NewPhrase $newPhrase
