function Get-EntraUser {
    param(
        [Parameter(Mandatory=$true)]
        [string]$UserId,

        [Parameter(Mandatory=$true)]
        [string]$AccessToken
    )

    if ([string]::IsNullOrWhiteSpace($UserId)) {
        Write-Warning "UserId is empty."
        return $null
    }

    $uri = "https://graph.microsoft.com/v1.0/users/$UserId"

    $headers = @{
        Authorization = "Bearer $AccessToken"
    }

    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Warning "Failed to retrieve user '$UserId': $($_.Exception.Message)"
        return $null
    }
}


# --- Test call ---
$testToken = "fake-token-123"
$result = Get-EntraUser -UserId "someone@domain.com" -AccessToken $testToken
$result