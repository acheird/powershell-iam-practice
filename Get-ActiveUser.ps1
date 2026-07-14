# Exercise 2 (Get-ActiveUser.ps1)
# Write a function Get-ActiveUser that takes a mandatory array of
# PSCustomObject (Users) as a parameter, marked with [AllowNull()].
# Include the same defensive null/empty check pattern. Use Where-Object
# to filter users whose IsActive property equals $true, then pipe into
# ForEach-Object to extract and return just the Name property of each
# matching user.

function Get-ActiveUser {
    param(
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [PSCustomObject[]]$Users
    )

    if ($null -eq $Users -or $Users.Count -eq 0) {
        Write-Warning "Δεν δόθηκε καμία λίστα users."
        return @()
    }

    $activeNames = $Users | Where-Object { $_.IsActive -eq $true } | ForEach-Object { $_.Name }

    return $activeNames
}

# Παράδειγμα κλήσης
$users = @(
    [PSCustomObject]@{ Name = "Angelo"; IsActive = $true },
    [PSCustomObject]@{ Name = "Maria"; IsActive = $false }
)
Get-ActiveUser -Users $users