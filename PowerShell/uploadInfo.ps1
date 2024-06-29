# make dir for blender render and make upload info for use
# create dir for blender render use
if (1 -eq 1 -and $args.Count -eq 1){ 
    $renderDir = Split-Path -Path $args[0] -LeafBase
    if ( -Not (Test-Path ../music_anim/$renderDir) ){
        echo "create ../music_anim/$renderDir for later blender render use"
        mkdir ../music_anim/$renderDir
    }
}
else{
    echo "Need give a file!!!"
}

# create upload info for youtube
if ( 1 -eq 1 ){
    if ($args[0] -Like "*.lrc"){
        # an array with song name and singer name
        $titleName= ((Get-Content -Path $args[0] -TotalCount 1) -Split ']')[1] -Split '-'
        #echo $titleName
        $highlight= ((Get-Content -Path $args[0] -Delimiter 'MV')[1] -Split '\[' -Split '\]')[2,4].trimEnd() 
        #echo $highlight
        "【动态歌词】 $($titleName[1]) 《$($titleName[0])》 $($highlight[0]) $($highlight[1]) ♥♪♫ "
    }
    elseif ($args[0] -Like "*.srt"){
        $text = Get-Content -Path $args[0] | Select-String -NotMatch '^[0-9]' | Out-String -Stream | Where {$_.Trim().Length -gt 0}
        $titleName=$text[0] -Split '-'
        #echo $titleName
        $lineNo=($text | Select-String 'MV').LineNumber
        $highlight=$text[$script:lineNo++,$lineNo]
        #echo $highlight
        "【动态歌词】 $($titleName[1]) 《$($titleName[0])》 $($highlight[0]) $($highlight[1]) ♥♪♫ "
    }
}
