Invoke-Command -ScriptBlock {Remove-Item D:\webroot\*.*} -ComputerName $name -Credential $Credential
#