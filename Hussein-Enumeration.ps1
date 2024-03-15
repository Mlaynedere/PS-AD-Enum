param(
    [switch]$GetDomainGroups,
    [string]$GroupName,
    [switch]$GetAllComputers,
    [switch]$GetOSInfo,
    [switch]$GetGroupPolicyObjects,
    [switch]$GetFileShares
)

$PrimaryDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.name
$DN = ([adsi]'').distinguishedName
$LDAP = "LDAP://$PrimaryDC/$DN"
$direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
$dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)

if ($GetDomainGroups) {
    $dirsearcher.Filter = "(objectCategory=group)"
    $result = $dirsearcher.FindAll()
    Write-Host "Domain Groups:"
    Foreach($obj in $result) {
        $obj.Properties["samAccountName"]
    }
    Write-Host "-------------------------------"
}

if ($GroupName) {
    $dirsearcher.Filter = "(&(objectCategory=group)(samAccountName=$GroupName))"
    $groupInfo = $dirsearcher.FindOne()
    if ($groupInfo) {
        Write-Host "Group Information for $($GroupName):"  # Fix here
        $groupInfo.Properties
    } else {
        Write-Host "Group $GroupName not found."
    }
    Write-Host "-------------------------------"
}

if ($GetAllComputers) {
    $dirsearcher.Filter = "(objectCategory=computer)"
    $result = $dirsearcher.FindAll()
    Write-Host "All Computers:"
    Foreach($obj in $result) {
        $obj.Properties["name"]
    }
    Write-Host "-------------------------------"
}

if ($GetOSInfo) {
    $dirsearcher.Filter = "(objectCategory=computer)"
    $result = $dirsearcher.FindAll()
    $OSInfo = @{}
    Foreach($obj in $result) {
        $computerName = $obj.Properties["name"]
        $OSInfo[$computerName] = $obj.Properties["operatingSystem"]
    }
    Write-Host "Operating System Information:"
    $OSInfo.GetEnumerator() | ForEach-Object {
        Write-Host "$($_.Key): $($_.Value)"
    }
    Write-Host "-------------------------------"
}

if ($GetGroupPolicyObjects) {
    Write-Host "All Group Policy Objects:"
    Write-Host "-------------------------------"
    Get-GPO -All
}

if ($GetFileShares) {
    Write-Host "File Share Information:"
    Write-Host "-------------------------------"
    Get-SmbShare
}

# Example of running the script with options
# .\script.ps1 -GetDomainGroups
# .\script.ps1 -GetAllComputers
# .\script.ps1 -GetOSInfo
# .\script.ps1 -GetGroupPolicyObjects
# .\script.ps1 -GetFileShares
# .\script.ps1 -GroupName "GroupName"
