param(
    [Parameter(Mandatory=$true)]
    [string]
    $ApiManagementName,
    [Parameter(Mandatory=$true)]
    [string]
    $ApiManagementResourceGroup,
    [Parameter(Mandatory=$true)]
    [string]
    $StorageAccountName,
    [Parameter(Mandatory=$true)]
    [string]
    $StorageResourceGroup,
    [Parameter(Mandatory=$true)]
    [string]
    $ContainerName
)

$blobName = "$ApiManagementName-$(Get-Date -Format 'yyyy-MM-dd-HH-mm-ss').bak"

$storageKey = (Get-AzStorageAccountKey -ResourceGroupName $StorageResourceGroup -StorageAccountName $StorageAccountName)[0].Value

$storageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $storageKey

Backup-AzApiManagement -ResourceGroupName $ApiManagementResourceGroup -Name $ApiManagementName `
    -StorageContext $storageContext -TargetContainerName $ContainerName -TargetBlobName $blobName