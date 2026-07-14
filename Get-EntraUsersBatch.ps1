function Get-EntraUsersBatch{
    params(
        [Parameter(Mandatory=$true)]
        [string[]]$UserIds,

        [Parameter(Mandatory=$true)]
        [string[]]$AccessToken
    )

    if (null -eq $UserIds -or $UserIds.Count -eq 0){
        Write-Warning "UserIds array is empty"
        return @()
    }

    $results = @()
    $failCount =@()

    foreach($id in $UserIds){
        $user = Get-EntraUser -UserId $id -AccessToken $AccessToken

        if($null -eq $user){
            $failCount++
        }
        else{
            $result += $user
        }
    }

    Write-Warning "$failCount out of $(UserIds.Count) users could not be retrieved."

    return $results
}