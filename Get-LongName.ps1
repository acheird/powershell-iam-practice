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
Get-LongNames -Names $employees