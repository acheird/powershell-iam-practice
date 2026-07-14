# Exercise 3 (Get-EntraUser.ps1)
# Write a function Get-EntraUser that takes a mandatory UserId (string)
# and a mandatory AccessToken (string). Call the Microsoft Graph REST
# endpoint (https://graph.microsoft.com/v1.0/users/<UserId>) using
# Invoke-RestMethod, sending the AccessToken as a Bearer token in the
# Authorization header. Wrap the call in Try/Catch to handle errors
# (e.g. user not found, invalid token) — on failure, write a warning
# and return $null; on success, return the response.
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