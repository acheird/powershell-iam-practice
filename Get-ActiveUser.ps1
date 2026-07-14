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
Get-ActiveUsers -Users $users