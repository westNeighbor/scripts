$logoText = "罗刹国落选村花"
$suffix = Get-Date -Format "yyyy_MM_dd"

# Create directories if they do not exist
$watermarkDir = "./watermark/$suffix"
$originDir = "./origin/$suffix"

if (-not (Test-Path -Path $watermarkDir)) {
    Write-Host "Creating directory $watermarkDir"
    New-Item -ItemType Directory -Force -Path $watermarkDir
}

if (-not (Test-Path -Path $originDir)) {
    Write-Host "Creating directory $originDir"
    New-Item -ItemType Directory -Force -Path $originDir
}

# Process each video file
$cut = $args[0]
Get-ChildItem -Path . -Filter *.mp4 | ForEach-Object {
    $file = $_
    $fileName = $file.Name
    $outName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)

    # Get video dimensions using ffprobe
    $videoWidth = & ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$file"
    $videoHeight = & ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$file"

    # Apply watermark animation with FFmpeg
    if ($cut -eq "cut") {
        & ffmpeg -i "$file" -vf "drawtext=text='$logoText':x=($videoWidth/2-text_w/2)*(1+sin(2*PI*t/50)):y=($videoHeight/2-text_h*3)*(1+cos(2*PI*t/300)):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=($videoWidth/25):fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5,crop=in_w:in_h-60.6:0:0" -crf 22  "$watermarkDir/${outName}_watermark.mp4"
    } else {
        & ffmpeg -i "$file" -vf "drawtext=text='$logoText':x=($videoWidth/2-text_w/2)*(1+sin(2*PI*t/50)):y=($videoHeight/2-text_h*2)*(1+cos(2*PI*t/300)):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=($videoWidth/25):fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5" -crf 22 "$watermarkDir/${outName}_watermark.mp4"
    }

    # Copy the original video
    & ffmpeg -i "$file" -c copy "$originDir/$outName.mp4"
}

