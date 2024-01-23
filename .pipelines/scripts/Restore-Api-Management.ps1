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

Write-Host "Script called with the following parameters:"
Write-Host "** ApiManagementName: $ApiManagementName"
Write-Host "** ApiManagementResourceGroup: $ApiManagementResourceGroup"
Write-Host "** StorageAccountName: $StorageAccountName"
Write-Host "** StorageResourceGroup: $StorageResourceGroup"
Write-Host "** ContainerName: $ContainerName"
Write-Host "** BackupFileName: $BackupFileName"

Write-Host "Restoring to Api Management instance $ApiManagementName from $BackupFileName"

Write-Host "Establishing storage context"
$storageKey = (Get-AzStorageAccountKey -ResourceGroupName $StorageResourceGroup -StorageAccountName $StorageAccountName)[0].Value

$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageKey

Write-Host "Begining restore operation, this will take a while"
Restore-AzApiManagement -ResourceGroupName $ApiManagementResourceGroup -Name $ApiManagementName `
    -StorageContext $StorageContext -SourceContainerName $ContainerName -SourceBlobName $BackupFileName
Write-Host "Restore operation complete"
