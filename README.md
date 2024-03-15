# PS-AD-Enum

This PowerShell script allows you to manage various aspects of Active Directory, such as retrieving domain groups, listing all computers, fetching OS information, retrieving group policy objects, and obtaining file share information.

## Usage

To use this script, run it in a PowerShell environment with the desired options:

```powershell
.\script.ps1 -GetDomainGroups
.\script.ps1 -GetAllComputers
.\script.ps1 -GetOSInfo
.\script.ps1 -GetGroupPolicyObjects
.\script.ps1 -GetFileShares
.\script.ps1 -GroupName "GroupName"
```
## Options
### GetDomainGroups
Retrieves all domain groups.

### GetAllComputers
Lists all computers in the domain.

### GetOSInfo
Fetches operating system information for all computers in the domain.

### GetGroupPolicyObjects
Retrieves all group policy objects.

### GetFileShares
Obtains information about file shares.

### GroupName
Provides information about a specific group in the domain.

## Example
To get information about a specific group:

```powershell
.\script.ps1 -GroupName "GroupName"
```
## Example Output
-Get all file shares
![image](https://github.com/Mlaynedere/PS-AD-Enum/assets/117475642/ddf70135-abe3-42bb-aa3c-41a13a4ed2fb)

```plaintext
Here I ran the script on a sample Windows Server virtual machine
```
Feel free to modify and extend this script according to your needs!


