# check_ss_certs

``check_ss_certs`` is a Nagios / Icinga plugin for checking for non self-signed trusted root or self-signed CA certificates. For some certificate-sensitive applications (*such as Skype for Business*) these certificates can force errors..

# Requirements
I successfully tested the plugin on Windows Server 2008 / 2012 R2 machines.

# Usage
This script needs to be executed on the Windows machine, e.g. using [NSClient++](https://www.nsclient.org/).

## Examples
The following example checks for non self-signed trusted root certificates:
```
PS >.\check_ss_certs.ps1
OK: No non self-signed trusted root certificates
```

Checking for self-signed CA certificates:
```
PS >.\check_ss_certs.ps1 -SelfSignedCA
OK: No self-signed intermediate certificates
```

# Installation
To install the plugin, move the PowerShell script to the ``plugins`` directory of your agent and alter the configuration, e.g. for NSClient++:
```
...
#check_ss_certs
check_ss_certs=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe c:\NSCP\plugins\check_ss_certs.ps1
```

Restart the service and schedule a service check.