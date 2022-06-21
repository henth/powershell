# Parametros de Senha #

$User = "domain\user"
$PWord = ConvertTo-SecureString -String "password" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Passando lista com os Servers #

ForEach ($Computer in Get-Content C:\scripts\servers.txt)
{

# Autenticando com o Server #

$session = New-PSSession -ComputerName $Computer -credential $Credential
 
# Copiando Arquivos para o Server #

Copy-Item -Path "C:\teste\aspnetcore-runtime-3.1.25-win-x64.exe" -Destination "C:\Temp\aspnetcore-runtime-3.1.25-win-x64.exe" -ToSession $session

# Instalando o .NET Core 3.1.25 #

Invoke-Command -Credential $Credential -ComputerName $Computer -ScriptBlock {Start-Process "C:\Temp\aspnetcore-runtime-3.1.25-win-x64.exe" -ArgumentList "/silent" -Verb RunAs -Wait}
}

# Validando Instalação .NET #

Invoke-Command -Credential $Credential -ComputerName $Computer -ScriptBlock {wmic product get description | findstr /C:.NET}
