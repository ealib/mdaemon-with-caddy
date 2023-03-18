REM mx1.example.com is not in the SAN list because it is the primary name
REM
REM mail.example.com is used to connect clients.
REM
REM SkipPortCheck is required because the HTTP server is neither the
REM built-in one nor IIS.
REM
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ^
	-ExecutionPolicy Bypass ^
	"C:\MDaemon\LetsEncrypt\letsencrypt.ps1" ^
    -AlternateHostNames mail.example.com ^
	-To "postmaster@example.com" ^
	-RemoveOldCertificates ^
	-SkipPortCheck 
