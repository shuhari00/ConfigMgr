﻿param (
$SMSProvider,
$StartingIP,
$EndingIP
)

Function Get-SiteCode
{
    $wqlQuery = “SELECT * FROM SMS_ProviderLocation”
    $a = Get-WmiObject -Query $wqlQuery -Namespace “root\sms” -ComputerName $SMSProvider
    $a | ForEach-Object {
        if($_.ProviderForLocalSite)
            {
                $script:SiteCode = $_.SiteCode
            }
    }
    return $SiteCode
}
# created by Tobias Weltner, MVP PowerShell, http://powershell.com/cs/blogs/tobias/archive/2011/02/20/creating-ip-ranges-and-other-type-magic.aspx
$ip1 = ([System.Net.IPAddress]$start).GetAddressBytes()
[Array]::Reverse($ip1)
$ip1 = ([System.Net.IPAddress]($ip1 -join '.')).Address

$ip2 = ([System.Net.IPAddress]$end).GetAddressBytes()
[Array]::Reverse($ip2)
$ip2 = ([System.Net.IPAddress]($ip2 -join '.')).Address

for ($x=$ip1; $x -le $ip2; $x++) {
$ip = ([System.Net.IPAddress]$x).GetAddressBytes()
[Array]::Reverse($ip)
$ip -join '.'
}
}