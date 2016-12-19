<# 
.SYNOPSIS
    This script checks for non self-signed trusted root or self-signed CA certificates.
.DESCRIPTION
    This script checks for non self-signed trusted root or self-signed CA certificates. For some certificate-sensitive applications (such as Skype for Business) these certificates can force errors.
.NOTES
    File Name  : check_certs.ps1
    Author     : Christian Stankowic - info@stankowic-development.net
.EXAMPLE
    check_ss_certs.ps1
    OK: No non self-signed trusted root certificates
.EXAMPLE
    check_ss_certs.ps1 -SelfSignedCA
    OK: No self-signed intermediate certificates
.LINK
    https://www.github.com/stdevel/check_ss_certs
#>

#############################################################################################

#defining parameters
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false,ValueFromPipeline=$true,HelpMessage="Checks for self-signed CA certificates")]
    [switch]$SelfSignedCA
)

if($SelfSignedCA) {
    #get state
    $state = Get-ChildItem Cert:\LocalMachine\CA -Recurse | Where-Object {$_.Issuer -eq $_.Subject } | ft

    #return code based on result
    if($state.Length -eq 0) {
        Write-Host "OK: No self-signed intermediate certificates"
        exit 0
    } else {
        Write-Host "CRITICAL:"$state.Length"self-signed intermediate certificates"
        exit 2
    }
}
else {
    #get state
    $state = Get-ChildItem Cert:\LocalMachine\Root -Recurse | Where-Object {$_.Issuer -ne $_.Subject} | ft
    
    #return code based on result
    if($state.Length -eq 0) {
        Write-Host "OK: No non self-signed trusted root certificates"
        exit 0
    } else {
        Write-Host "CRITICAL:"$state.Length"self-signed trusted root certificates found"
        exit 2
    }
}