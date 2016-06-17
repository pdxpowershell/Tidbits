<#
.Synopsis
   Used to generate traffic against a provided url
.DESCRIPTION
   Generate a web load against a url
.EXAMPLE
   Start-WebTrafficLoad.ps1 -Url www.google.com -NumOfRuns 100 -UseSsl -WithTimeout
.EXAMPLE
   Start-WebTrafficLoad.ps1 -Url www.yahoo.com -NumOfRuns 10 
#>
    [CmdletBinding()]
    Param
    (
            # url to target load against
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            $Url, 

            # number of times to hit the target page
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=1)]
            [int]$NumOfRuns,

            # use if the target requires ssl connections
            [Parameter(Mandatory=$false,
                       ValueFromPipelineByPropertyName=$true,
                       Position=2)]
            [switch]$UseSsl, 

            # use if it is desired to pause between each HTTP GET
            [Parameter(Mandatory=$false,
                       ValueFromPipelineByPropertyName=$true,
                       Position=3)]
            [switch]$WithTimeout

    )

if($UseSsl.IsPresent){
    $Uri = "https://$Url/"
}
else{ 
    $Uri = "http://$Url/"
} 

$i = 0
 while ($i -le $NumOfRuns) {
     try {
     [net.httpWebRequest]
     $req = [net.webRequest]::create($Uri)
     $req.method = "GET"
     $req.ContentType = "application/x-www-form-urlencoded"
     $req.TimeOut = 60000 

    $start = get-date
     [net.httpWebResponse] $res = $req.getResponse()
     $timetaken = ((get-date) - $start).TotalMilliseconds 

     Write-Output $res.Content
     Write-Output ("{0} Status Code: {1} ResponseTime: {2}" -f (get-date), $res.StatusCode.value__, $timetaken)
     $req = $null
     $res.Close()
     $res = $null
     } catch [Exception] {
     Write-Output ("{0} {1}" -f (get-date), $_.ToString()) | ft -AutoSize
     }
     $req = $null 
     if($WithTimeout.IsPresent){

        Start-Sleep -Milliseconds 200

    }
     $i++
 }

