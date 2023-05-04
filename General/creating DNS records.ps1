#$DNSZones = Get-ChildItem -Path "" -Force
az login
az accounts set
$rg = "ourdnszones"
foreach ($dosya in $DNSZones) {
    
    
    $zonename = $dosya.BaseName.TrimEnd(".")
    # $zonename
    az network dns zone create --resource-group $rg --name $zonename
             
    $icerik = (Get-Content $dosya | ConvertFrom-Json).ResourceRecordSets
    
    foreach($ic in $icerik){
    $rsname = $ic.Name.TrimEnd(".")
        if($ic.Type.Equals("A")){
            if($rsname.Equals($zonename)){
                $rsname = "@"
            }
            $rsname = $rsname.Replace("." + $zonename, "")

            if($ic | Get-Member -Name AliasTarget){
                
                az network dns record-set ptr add-record -g $rg -z $zonename -n $rsname -d $ic.AliasTarget.DNSName

            } else {


                az network dns record-set a add-record --ipv4-address $ic.ResourceRecords.Get(0).Value --record-set-name $rsname --resource-group $rg --zone-name $zonename  --ttl $ic.TTL

            }
        } elseif($ic.Type.Equals("MX")){
            $rsname = "@"
            $rsname = $rsname.Replace("." + $zonename, "")
            foreach($ivs in $ic.ResourceRecords){
                $p = $ivs.Value.Split(" ")
                # az network dns record-set mx add-record --exchange
                #                       --preference
                #                       --record-set-name
                #                       --resource-group
                #                       --zone-name
                #                       [--if-none-match]
                #                       [--subscription]
                #                       [--ttl]
                az network dns record-set mx add-record -g $rg -z $zonename -n $rsname -e $p[1] -p $p[0]  --ttl $ic.TTL
            }
        } elseif($ic.Type.Equals("CNAME")){
        $rsname = $rsname.Replace("." + $zonename, "")
            # az network dns record-set cname create --name
            #                          --resource-group
            #                          --zone-name
            #                          [--if-match]
            #                          [--if-none-match]
            #                          [--metadata]
            #                          [--subscription]
            #                          [--target-resource]
            #                          [--ttl]

            az network dns record-set cname create -g $rg -z $zonename -n $rsname --ttl $ic.TTL
            

            #az network dns record-set cname set-record --cname
            #                               --record-set-name
            #                               --resource-group
            #                               --zone-name
            #                               [--if-none-match]
            #                               [--subscription]
            #                               [--ttl]
            
            az network dns record-set cname set-record -g $rg -z $zonename -n $rsname -c $ic.ResourceRecords.Get(0).Value  --ttl $ic.TTL
        
        } elseif($ic.Type.Equals("TXT")){

            # az network dns record-set txt add-record --record-set-name
            #                             --resource-group
            #                             --value
            #                             --zone-name
            #                             [--if-none-match]
            #                             [--subscription]

            if($rsname.Equals($zonename)){
                $rsname = "@"
            }
            $rsname = $rsname.Replace("." + $zonename, "")
            az network dns record-set txt create -g $rg -z $zonename -n $rsname --ttl $ic.TTL
            foreach($trecords in $ic.ResourceRecords){
                # az network dns record-set txt update --name
                #                     --resource-group
                #                     --zone-name
                #                     [--add]
                #                     [--force-string]
                #                     [--if-match]
                #                     [--if-none-match]
                #                     [--metadata]
                #                     [--remove]
                #                     [--set]
                #                     [--subscription]
                #                     [--target-resource]
                az network dns record-set txt add-record --record-set-name $rsname --resource-group $rg --value $trecords.Value --zone-name $zonename
                
            }
            

        } elseif($ic.Type.Equals("SRV")){
        $rsname = $rsname.Replace("." + $zonename, "")
           # az network dns record-set srv add-record --port
           #                              --priority
           #                              --record-set-name
           #                              --resource-group
           #                              --target
           #                              --weight
           #                              --zone-name
           #                              [--if-none-match]
           #                              [--subscription]

           # AWS's way Enter multiple values on separate lines. Format: [priority] [weight] [port] [server host name] i.e. 1 100 5061 sipfed.online.lync.com
           $vall = $ic.ResourceRecords.Get(0).Value
           $parts = $vall.Split(" ")
           az network dns record-set srv add-record -g $rg -z $zonename -n $rsname  -t $parts[3] -r $parts[2] -p $parts[0] -w $parts[1] 

        }    
    }    
}