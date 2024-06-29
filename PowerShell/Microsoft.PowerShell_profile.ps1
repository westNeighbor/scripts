# Add VS Devenv
Import-Module "$env:ProgramFiles\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell -VsInstallPath "$env:ProgramFiles\Microsoft Visual Studio\2022\Community" -DevCmdArguments '-no_logo' -StartInPath "C:\Users\mhzhao\"
#$env:GOOGLE_APPLICATION_CREDENTIALS="C:\Users\mhzhao\Documents\charismatic-cab-417516-b32994196d5a.json"
Function macbook {ssh mhzhao@macbook16}
Function macbookftp {sftp mhzhao@macbook16}
