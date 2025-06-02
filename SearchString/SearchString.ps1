$readInputPath = 1 # true means should read input path this iteration; set based on menu after each search
$repeat = 1 # true means perform another search; checked after each search

# Each iteration is one search
do {
    # Read path if necessary and pattern to search
    if ($readInputPath) {
        $inputPath = Read-Host "Enter the path of the directory and subdirectories to search"
    }
    $inputPattern = Read-Host "Enter a string to search for"

    # Searches path for string and outputs to table in console
    Get-ChildItem $inputPath -Recurse -file | Select-String -pattern $inputPattern | Foreach-Object {
        [PSCustomObject]@{
            "Relative File Path" = $_.path.replace($inputPath, "")
            "Line Number" = $_.linenumber
            Line = $_.line.trim()
        }
    } | Format-Table -autosize
    
    # Search, search and set path, or close
    $menuOption = Read-Host("Menu`n1) Search a different string.`n2) Set a different directory and search a different string.`n`nChoose one of the following options and press enter, or press enter to close.")
    Switch ($menuOption) {
        1 {
            $readInputPath = 0
        }
        2 {
            $readInputPath = 1
        }
        default {
            $repeat = 0
        }
    }
} while ($repeat)