function Test-PortConnectivity {
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true)]
        [string]$TargetHost,

        [parameter(mandatory=$true)]
        [int32]$TargetPort,

        [int32] $Timeout = 10000

    )

    $outputObj = New-Object -TypeName PSobject
    $outputObj | Add-Member -MemberType NoteProperty -Name TargetHostName -Value $TargetHost

    if(Test-Connection -ComputerName $TargetHost -Count 2) {

        $outputObj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "ONLINE"
    }
    else{
        $outputOj | Add-Member -MemberType NoteProperty -Name TargetHostStatus -Value "OFFLINE"
    }

    $outputObj | Add-Member -MemberType NoteProperty -Name PortNumber -Value $TargetPort

    $Socket = New-Object System.Net.Sockets.TcpClient
    $Conn = $Socket.BeginConnect($TargetHost,$TargetPort,$null,$null)
    $Conn.AsyncWaitHandle.WaitOne($Timeout,$false) | Out-Null

    if($Socket.Connected -eq $true) {
        $outputObj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Success"
    }
    else{
        $outputObj | Add-Member -MemberType NoteProperty -Name ConnectionStatus -Value "Failed"

    }

    $Socket.Close() | Out-Null
    $outputObj | select TargetHostName,TargetHostStatus, PortNumber, ConnectionStatus | ft -AutoSize 
}

Test-PortConnectivity
