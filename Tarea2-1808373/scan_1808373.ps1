# Jesús Alfonso Hernández Topetes



function Escaneo-PuertosRed{ 
 $ScanAll = ""
    
    $waittime = 400
    $liveports = @()
   
    $destip = @() 
          
    $Portarray = @(20,21,22,23,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5986,8080,10000)

    

    # -------------- Get the Details From The User -------------

    
    Write-Output ""

    # Get the Target/s
    
    Write-Output "Please enter either an IP Address, URL or File Path (Example: C:\Temp\IPList.txt)....."
    
    [string]$Typeofscan = Read-Host -Prompt "Target"
  

    if ($Typeofscan -like "*txt") {
    
    $PulledIPs = Get-Content $Typeofscan
    
    foreach ($i in $PulledIPs) {

    # Fill destination array with all IPs
    
    $destip += $i
    
    } # for each

    }

    else {
    
    # Single Scan

    $destip = $Typeofscan
    
    }


    # ------------------- Get the Ports -----------------
    Write-Output "`n"
    Write-Output "Option 1:  Common Scan |  Option 2:  Full Scan (1-65535) |  Options 3:  Quick Scan (Less Accurate)"
    Write-Output "--------------------------------------------------------------------------------------------------"

    $ScanPorts = Read-Host -Prompt "Option Number" 

    if ($ScanPorts -eq 1) {$ScanAll = ""}
    if ($ScanPorts -eq 2) {$ScanAll = "True"}
    if ($ScanPorts -eq 3) {$ScanAll = "Quick"}
    if ($ScanPorts -ne 1 -AND $ScanPorts -ne 2 -AND $ScanPorts -ne 3){exit}



  # --------------- Get the Ports -------------------------------------

 
    if ($ScanAll -eq "True") {

    $waittime = 400
    $Portarray = 1..65535 
    
    }

    if ($ScanAll -eq "Quick") {

    $waittime = 40
    $Portarray = 1..65535

    }

    else {
    
    # Portarray remains the same (Common ports)

    }



    #----------------------- SCAN -----------------------------------------

    
    Write-Output ""
    Write-Output "Running Scan................"
    

    foreach ($i in $destip){ # Scan Every Dest



    foreach ($p in $Portarray){


    $TCPObject = new-Object system.Net.Sockets.TcpClient

    $Result = $TCPObject.ConnectAsync($i,$p).Wait($waittime)


    if ($Result -eq "True") {
    
    $liveports += $p  

    }


    } # For each Array

    
    # -------------------------- Output Results ---------------------------------
    
    Write-Output "--------------------------------------------------------------------------------------------------"
    Write-Output ""
    Write-Output "Target: $i"
    Write-Output ""
    Write-Output "Ports Found: "
    Write-Output ""
    Write-Output $liveports
    Write-Output ""
    Write-Output ""
    Write-Output "Known Services:"
    Write-Output ""
    Write-Output $Knownservices
    Write-Output ""
    

    #Clear Array for next
    $liveports = @()

    

    } # For Each $i in DestIP
    
    
    }




do{
    do {
    Write-Host "`n====================== Script========================="
    Write-Host "`t1. Escaneo de toda la subred"
    Write-Host "`t2. Escaneo de puertos para un equipo o direccion ip en particular"
    Write-Host "`t3. Escaneo de puertos para todos los equipos que esten activos en la red."
    Write-Host "`t4. Salir'"
    Write-Host "========================================================"
    $choice = Read-Host "`nEnter Choice"
    } until (($choice -eq '1') -or ($choice -eq '2') -or ($choice -eq '3')  -or ($choice -eq '4'))
    switch ($choice) {
        '1'{
            Escanear-Subred
        }
        '2'{
            Escanear-PuertosIP
        }
        '3'{
            Escaneo-PuertosRed
        }
        
        '4'{
            Return
        }

    }
}until($choice -eq '4')