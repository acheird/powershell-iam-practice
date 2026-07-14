# Exercise 4 (Get-EntraUsersBatch.ps1)
# Write a function Get-EntraUsersBatch that takes a mandatory array
# of UserIds (string[]) and a mandatory AccessToken (string). Include
# a defensive null/empty check on the UserIds array. For each UserId,
# call Get-EntraUser to retrieve the user. Collect successful results
# into an array, filtering out any failures (nulls). At the end, use
# Write-Warning to report how many of the requested users could not
# be retrieved (e.g. "3 out of 10 users could not be retrieved").

function Get-EntraUsersBatch {
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$UserIds,

        [Parameter(Mandatory=$true)]
        [string]$AccessToken
    )

    if ($null -eq $UserIds -or $UserIds.Count -eq 0) {
        Write-Warning "UserIds array is empty."
        return @()  # return an empty array instead of null, so the caller can safely .Count or foreach the result
    }

    $results = @()   # will be filled with successfully retrieved users
    $failCount = 0    # counts failed calls

    foreach ($id in $UserIds) {
        $user = Get-EntraUser -UserId $id -AccessToken $AccessToken

        if ($null -eq $user) {
            $failCount++
        }
        else {
            $results += $user
        }
    }

    Write-Warning "$failCount out of $($UserIds.Count) users could not be retrieved."

    return $results
}