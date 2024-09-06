$PSDefaultParameterValues['*:Encoding'] = 'utf8'

$current_user = query session | select-string console | foreach { -split $_ } | select -index 1
$group = "Administrateurs"
$members = (Get-LocalGroupMember -Group $group | Select -ExpandProperty Name) -replace '.*\\', ''

if ($members -contains $current_user -and $current_user -notlike "*admin*"){
    Remove-LocalGroupMember -Group "Administrateurs" -Member $current_user
    Get-LocalGroupMember -Group $group | Select -ExpandProperty Name
    Write-Host "`nL'utilisateur $current_user n'est plus administrateur local du poste`n" -ForegroundColor Green
    Exit
}
else {
    Get-LocalGroupMember -Group $group | Select -ExpandProperty Name
    Write-Host "`nAucune action requise pour l'utilisateur connecté`n" -ForegroundColor Yellow
}