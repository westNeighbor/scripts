# dl_sound.ps1
$outDir="."
if ($args.count -eq 1){
    yt-dlp -x -f 'bestaudio[ext=m4a]' -o "$outDir/%(playlist_index)s.viewer%(view_count)d.  resolution%(resolution)s.fps%(fps)d.%(ext)s" $args[0]
}
elseif ($args.count -eq 2){
    yt-dlp -x -f 'bestaudio[ext=m4a]' --postprocessor-args $args[1] -o "$outDir/%(title)s.                viewer%(view_count)d.resolution%(resolution)s.fps%(fps)d.%(ext)s" $args[0]
}
else {
    echo "parameter is not correct!!!"
}
