# Create parameters for the variables defined below.  All variables are strings
# and variable names should follow Pascal case naming conventions.
param(
    [string]
    $ApiManagementName,
    [string]
    $ApiManagementResourceGroup,
    [string]
    $StorageAccountName,
    [string]
    $StorageResourceGroup,
    [string]
    $ContainerName,
    [string]
    $BackupFileName
)

Write-Host "Restoring to Api Management instance $ApiManagementName from $BackupFileName"

Write-Host "Establishing storage context"
$storageKey = (Get-AzStorageAccountKey -ResourceGroupName $StorageResourceGroup -StorageAccountName $StorageAccountName)[0].Value

$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageKey

Write-Host "Begining restore operation, this will take a while"
Restore-AzApiManagement -ResourceGroupName $apiManagementResourceGroup -Name $apiManagementName `
    -StorageContext $storageContext -SourceContainerName $containerName -SourceBlobName $BackupFileName
Write-Host "Restore operation complete"
