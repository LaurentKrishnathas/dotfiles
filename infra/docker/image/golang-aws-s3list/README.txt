
Deploying as Windows service:
	build windows artifacts:
	/> make buildDockerRedirectWindowExe

	download nssm via http://nssm.cc/release/nssm-2.24.zip

	install service on windows:
	/> nssm install  [serviceName]  c:\redirec\redirect.exe

	update env variable ex: port=89
	start service and test
	setting logs:
		nssm set [serviceName] AppStdout \path\to\service.out.log
        nssm set [serviceName] AppStderr \path\to\service.err.log