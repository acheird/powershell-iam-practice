$users = Import-Csv -Path "C:\Data\users.csv"

$filtered = $users | Where-Object { $_.Department -eq "Finance" -and $_.Active -eq "True" }

$result = $filtered | ForEach-Object {
    [PSCustomObject]@{
        Name        = $_.Name
        AccessLevel = "ReadOnly"
    }
}

$result | Export-Csv -Path "C:\Data\finance_readonly.csv" -NoTypeInformation