$printers = Get-CimInstance -ClassName 'Win32_Printer'
foreach ($printer in $printers) {
	Write-Output "Working on $printer"
	$printer.EnableBIDI = $false
	Set-CimInstance -InputObject $printer
}