$WatchFolder = "F:\Watch_videos" # change this to the folder you want to watch for new files
$ConvertedFolder = "F:\Converted" # change this to the folder you want to store the converted files
$HandBrakeCLI = "C:\Program Files\HandBrake\HandBrakeCLI.exe" # change this to the path to your HandBrakeCLI executable
$ServerUser = "" # change this to your server username
$ServerHost = "" # change this to your server IP
$ServerIncoming = "/home/User/incoming" # change this to the path on your server where you want to store the converted files which will then be moved by the bash script

# Process file and convert the file
function Process-Video($filePath) {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
    $convertedFile = Join-Path $ConvertedFolder "$fileName.mp4"

    Write-Host "Converting $filePath..."
    & $HandBrakeCLI -i $filePath -o $convertedFile -e x264 -q 20 -B 160

    Write-Host "Uploading $convertedFile..."
    scp $convertedFile "${ServerUser}@${ServerHost}:$ServerIncoming"


    Write-Host "Upload complete for $fileName.mp4 !!!"
    Remove-Item $filePath
    Remove-Item $convertedFile
}

# Watch the folder for new media
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $WatchFolder
$watcher.Filter = "*.mkv"
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Created -Action {
    Start-Sleep -Seconds 5  # wait for file to finish downloading
    Process-Video $Event.SourceEventArgs.FullPath
}

Write-Host "Watching $WatchFolder for new files..."
while ($true) { Start-Sleep -Seconds 10 }
