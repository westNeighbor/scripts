# remakeMeta.ps1
$inputDir='./pictures'
if ( 1 -eq 0 ) {
    echo "adding meta info ..."
    exiftool -all= -author=mhstar -contact="tttom.jjjack@gmail.com" -copyright="All reserved by mhstar" -comment="This picture is originally produced by mhstar, if you want to use or redistribute it, please contact the author through the email tttom.jjjack@gmail.com" $inputDir/test.jpg
    exiftool -json -tagsfromfile fakeInfo.json $inputDir/test.jpg
    echo yes | exiftool -delete_original $inputDir
    echo "adding meta info done"
}

# convert to jpg
if ( 1 -eq 0 ) {
    echo "converting png to jpg ..."
    foreach ($image in Get-ChildItem "$inputDir\*.png"){
        #echo $image
        #$file=Split-Path -Path $image -Leaf
        $newName=-join(((Split-Path -Path $image -LeafBase) -Split "-")[0],"_",$(date -F yyyy_MM_dd))
        magick $image $inputDir/$newName.jpg
        rm $image
    }
    echo "converting png to jpg done" 
}

#rename
if ( 1 -eq 1 ) {
    echo "rename pictures ..."
    foreach ($image in Get-ChildItem "$inputDir/*.jpg")
    {
        if ($image -match "test*" ){
            continue
        }
        else{
            $suffix = $(date -F yyyy_MM_dd)
            #$suffix = "2024_06_10"
            if (-Not (Test-Path $inputDir/$suffix)){ 
                echo "mkdir $inputDir/$suffix"
                mkdir $inputDir/$suffix
            }
            $newName=-join(((Split-Path -Path $image -LeafBase) -Split "-")[0],"_",$suffix)
            mv "$image" "$inputDir/IMG_${newName}.jpg"
        }
    }
    echo "rename done" 
}

# adding watermark to jpg
if ( 1 -eq 1 ){
    echo "adding watermark ..."
    $lineNo=924
    $name=((Get-Content -Path ../sqlite/db/girlFigures.csv -TotalCount $lineNo)[-1] -Split " ")[0] 
    foreach ($image in Get-ChildItem "$inputDir/*.jpg"){
        #echo $image
  	    $outName=(Split-Path -Path $image -Leaf)
        echo $outName
        if (-Not (Test-Path $inputDir/watermark)){ 
            echo "mkdir $inputDir/watermark"
            mkdir $inputDir/watermark
        }
        if (-Not (Test-Path $inputDir/watermark/$name)){
            echo "mkdir $inputDir/watermark/$name"
            mkdir $inputDir/watermark/$name
        }
#        convert $image -gravity SouthEast -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.2)" -annotate +200+80 "伶仃问道" -gravity NorthWest -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.2)" -annotate +200+80 "伶仃问道" -gravity Center -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.05)" -annotate 0 "伶仃问道" $inputDir/watermark/$outName 
        magick $image -gravity SouthEast -pointsize 80 -font 'C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf' -fill "rgba(255,255,255,0.8)" -annotate +200+80 "落选村花 $name" -gravity NorthWest -pointsize 80 -font 'C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf' -fill "rgba(255,255,255,0.8)" -annotate +200+80 "落选村花 $name" -gravity Center -pointsize 80 -font 'C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf' -fill "rgba(255,255,255,0.05)" -annotate +0+180 "落选村花 $name" $inputDir/watermark/$name/$outName 
#        convert $image -gravity SouthEast -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(5,255,5,0.7)" -annotate +200+80 "obo" -gravity NorthWest -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(255,255,255,0.7)" -annotate +200+80 "obo" -gravity Center -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(255,255,255,0.05)" -annotate 0 "obo" $inputDir/watermark/$outName 
    }
    echo "adding watermark done" 
}
