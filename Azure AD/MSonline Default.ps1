Install-Module -Name MSonline
$msolcred = get-credential
connect-msolservice -credential $msolcred