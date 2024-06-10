# db-setup.ps1
$serverInstance = "localhost\SQLEXPRESS"
$databaseName = "FinancialManagement"
$sqlScriptPath = "C:\path\to\your\schema.sql"

Invoke-Sqlcmd -ServerInstance $serverInstance -InputFile $sqlScriptPath