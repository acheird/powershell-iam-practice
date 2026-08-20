function New-EntraUser {
    param(
        [Parameter(Mandatory=$true)]
        [string]$DisplayName,

        [Parameter(Mandatory=$true)]
        [string]$UserPrincipalName,

        [Parameter(Mandatory=$true)]
        [string]$AccessToken
    )

    if ([string]::IsNullOrWhiteSpace($DisplayName) -or [string]::IsNullOrWhiteSpace($UserPrincipalName)) {
        Write-Warning "DisplayName or UserPrincipalName are empty."
        return $null
    }

    $uri = "https://graph.microsoft.com/v1.0/users"

    $headers = @{
        Authorization = "Bearer $AccessToken"
        "Content-Type" = "application/json"
    }

    $userData = @{
        accountEnabled    = $true
        displayName       = $DisplayName
        userPrincipalName = $UserPrincipalName
        mailNickname      = $DisplayName.Replace(" ", "")
        passwordProfile   = @{
            forceChangePasswordNextSignIn = $true
            password                      = "TempPass123!"
        }
    }

    $bodyJson = $userData | ConvertTo-Json -Depth 3

    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $bodyJson
        return $response
    }
    catch {
        Write-Warning "Failure to create user '$DisplayName': $($_.Exception.Message)"
        return $null
    }
}

# Παράδειγμα κλήσης
New-EntraUser -DisplayName "Test User" -UserPrincipalName "testuser@contoso.com" -AccessToken $testToken