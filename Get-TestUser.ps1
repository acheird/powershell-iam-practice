function Get-TestUser {
    param(
        [Parameter(Mandatory=$true)]
        [string]$UserId
    )

    if ([string]::IsNullOrWhiteSpace($UserId)) {
        Write-Warning "UserId is empty."
        return $null
    }

    $uri = "https://jsonplaceholder.typicode.com/users/$UserId"

    try {
        $response = Invoke-RestMethod -Uri $uri -Method Get
        return $response
    }
    catch {
        Write-Warning "Failed to retrieve user '$UserId': $($_.Exception.Message)"
        return $null
    }
}



