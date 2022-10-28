<#
    Equivalents to the Group Policy Settings
        ComplexityEnabled = Passwords must meet complexity requirements
        MaxPasswordAge = Maximum password age
        MinPasswordAge = Minimum password age
        MinPasswordLength = Minimum password length
        PasswordHistoryCount = Enforce password history
        ReversibleEncryptionEnabled = Store passwords using reversible encryption
#>

#View the current domain password policy
Write-Host "Default Domain Policy"

Get-ADDefaultDomainPasswordPolicy

#Set the account lockout settings
<# $PasswordPolicy = @{
    Identity             = 'techsnips.local'
    ComplexityEnabled    = $true
    MinPasswordLength    = 10
    MinPasswordAge       = "1.00:00:00"
    MaxPasswordAge       = "90.00:00:00"
    PasswordHistoryCount = 10
} #>

#Set-ADDefaultDomainPasswordPolicy @PasswordPolicy
#Get-ADDefaultDomainPasswordPolicy

#Change a single setting
#Set-ADDefaultDomainPasswordPolicy -Identity "techsnips.local" -MinPasswordAge "1.00:00:00"
#Get-ADDefaultDomainPasswordPolicy

#5b
Write-Host "TRUST "
Get-ADTrust -Filter *

#Get-AdUser 5d
Write-Host "PASSWORD EXPIRATION"

Get-AdUser -Filter * -Properties passwordlastset, passwordneverexpires

#6a
Write-Host " GROUP INFORMATION"
Get-ADGroupMember "Mygroup-Name-Users-Production"

#10a
Write-Host "PATCHES LIST"
wmic qfe list full /format:texttablewsys
Get-HotFix
#Both will get more or less same results

#2a
Write-Host "PROPERTY ENABLED"
Get-ADUser -Filter * -Property Enabled | Where-Object { $_.Enabled -like "true" } | Format-Table Name, Enabled -Autosize


