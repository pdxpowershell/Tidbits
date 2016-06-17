<#
.Synopsis
   Uses invoke-webrequest to retrieve rss feeds from a defined url and reads it aloud
.DESCRIPTION
   Using invoke-webrequest an RSS url is retrieved and contents are saved to an xml file
   The contents are the read aloud using the SAPI.SPVoice com object that is a part of 
   windows.
.EXAMPLE
   Start-PoshFeed
#>
function Start-RssFeed
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Url = "https://connect.microsoft.com/rss/99/RecentFeedbackForConnection.xml"
    )

    Begin
    {
        $Voice = New-Object -ComObject "SAPI.SPVoice"
        $Voice.Rate = 2
        $VoiceOption = $Voice.GetVoices()
    }
    Process
    {
        $TrimUrl = $url -replace 'http://',''
        $Voice.Speak("This tool demonstrates Powershell using the Speech API with an RSS feed")
        Invoke-WebRequest -Method Get -Uri $url -OutFile $ENV:PUBLIC\Documents\ConnectFeed.xml
        [xml]$Content = Get-Content C:\Users\Public\Documents\ConnectFeed.xml
        $Feed = $Content.rss.channel

        if($Feed.Item -ne $null){
            $Voice.Speak("Source - $($Feed.title)")
            $Feed.Item | % {
                Write-Host $_.Title
                $Voice.Speak("Headline" + $_.title); 
                Write-Host $_.updated
                $PublishDate = $_.updated -replace '(T[0-9]*:[0-9]*:[0-9]*-[0-9]*:[0-9]*)',''        
                $Voice.Speak("Date Published" + $PublishDate);
                Write-Host $_.description  
                $Voice.Speak($_.description) }
        }
    }
    End
    {
        Clear-Variable -Name Feed
    }
}

Start-RssFeed