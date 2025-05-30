$inputPath = Read-Host "Enter the path of the directory and subdirectories to search"
$inputPattern = Read-Host "Enter a string to search for"

Get-ChildItem $inputPath -Recurse -file | Select-String -pattern $inputPattern | Foreach-Object {
    [PSCustomObject]@{
        "Relative File Path" = $_.path.replace($inputPath, "")
        "Line Number" = $_.linenumber
        Line = $_.line.trim()
    }
} | Format-Table -autosize
    

Read-Host "Search complete. Press enter to close"