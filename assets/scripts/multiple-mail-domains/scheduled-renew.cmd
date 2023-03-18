REM mx1.example.com is not in the SAN list because it is the primary name
REM
REM mail.example.com, mail.example1.com, mail.example2.com are used to
REM connect clients.
REM
REM SkipPortCheck is required because the HTTP server is neither the
REM built-in one nor IIS.
REM
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ^
	-ExecutionPolicy Bypass ^
	"C:\MDaemon\LetsEncrypt\letsencrypt.ps1" ^
    -AlternateHostNames mail.example.com,mx1.example1.com,mail.example1.com,mx1.example2.com,mail.example2.com ^
	-To "postmaster@example.com" ^
	-RemoveOldCertificates ^
	-SkipPortCheck 
