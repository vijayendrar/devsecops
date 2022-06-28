# Run PowerShell: https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/starting-windows-powershell?view=powershell-7#with-administrative-privileges-run-as-administrator
# Create a folder somewhere on your system, for example: C:\GitLab-Runner
New-Item -Path 'C:\GitLab-Runner' -ItemType Directory

# Change to the folder
Set-Location 'C:\GitLab-Runner'

# Download binary
Invoke-WebRequest -Uri "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe" -OutFile "gitlab-runner.exe"

# Register the runner (steps below), then run
.\gitlab-runner.exe install
.\gitlab-runner.exe start

# configure the runner for windows 
Set-Location 'C:\GitLab-Runner'
.\gitlab-runner.exe  register  --non-interactive  --executor "shell" --url "https://gitlab.com/" --registration-token "place your token" --description "windows+runner" --tag-list "windows" --run-untagged="false"