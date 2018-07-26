# NetOps - David Monaghan 2018
#
#

# Set the AC-Infrastructure subscription

Select-AzureRmSubscription -Subscription AC-Infrastructure


function peerVnet {
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$rvnetNetId
        [string[]]$vnetPeerTarget
    )
    
    $vnetPeerTarget = Read-Host "Which VNET are you looking to peer the Hub with [Enter new peering target]"
    $rvnetNetId = Read-Host "What is the UUID of the Vnet we are peering with? e.g[/subscriptions/c6d6b051-f122-44dc-ba45-6b2331c1e8ee/resourceGroups/dpd-rnd-vault-consul/providers/Microsoft.Network/virtualNetworks/d
    pd-rnd-vault-consul]"
    $vnetHub = Get-AzureRmVirtualNetwork -Name AC-Infrastructure-Hub-vnet0 -ResourceGroupName AC-Infrastructure-Hub

    # Attempt Peering with error handling

    try {
        Add-AzureRmVirtualNetworkPeering `
        -Name $vnetPeerTarget `
        -VirtualNetwork $vnetHub `
        -RemoteVirtualNetworkId $rvnetNetId `
        -ErrorAction Stop
    } catch [System.SystemException] {
        Write-Output "Base Exception"
    } catch {
        Write-Output "Unhandled Exception"
    }
}