
if (!(Get-InstalledModule Microsoft.Graph.Teams)) {
    Install-Module Microsoft.Graph.Teams -Force
}

Connect-MgGraph -Scopes "Group.ReadWrite.All","User.Read.All","Chat.ReadBasic","Chat.Read","Chat.ReadWrite" -TenantId "179ce9e3-5993-44a1-bed1-c16e1b6aa614" -ForceRefresh




Get-MgChat -Search 

