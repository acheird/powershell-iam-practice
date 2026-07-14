# Exercise 1 (Get-LongName.ps1)
# Write a function Get-LongName that takes a mandatory array of strings
# (Names) as a parameter, marked with [AllowNull()] to allow $null to be
# passed in without PowerShell blocking it before the function body runs.
# Include a defensive check at the start: if $Names is $null or empty,
# write a warning and return an empty array. Otherwise, use Where-Object
# to filter and return only the names longer than 5 characters.

function Get-LongName {
    param(
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [string[]]$Names
    )

    # Έλεγχος αν το input είναι null ή κενό - το βασικό defensive pattern
    if ($null -eq $Names -or $Names.Count -eq 0) {
        Write-Warning "Δεν δόθηκε καμία λίστα ονομάτων."
        return @()
    }

    # Where-Object φιλτράρει τη λίστα βάσει συνθήκης
    $result = $Names | Where-Object { $_.Length -gt 5 }

    return $result
}

# Παράδειγμα κλήσης
$employees = @("Angelo", "Maria", "Konstantinos", "Elpida", "Nick")
Get-LongName -Names $employees