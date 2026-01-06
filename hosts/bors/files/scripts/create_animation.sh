

for file in ./*.mp4
do
      filename="${file%.*}"
      # STORYBOAD ffmpeg -i ${file} -vf "select='gt(scene,0.4)',scale=640:480,tile=2X2" -frames:v 1 scene_storyboard.jpg
      ffmpeg -i ${file}  -vf "select=not(mod(n\,10)),scale=640:480"  -vsync 0 ./png/${filename}_4_2_frames_10_%03d.png
done


ffmpeg -framerate 60 -pattern_type glob -i '*.png' -r 30 anim.gif

ffmpeg -framerate 90 -pattern_type glob -i '*.png' -r 30 anim4.gif

for file in ./*
do
      filename="${file%.*}"
      ffmpeg -i ${file} -ss 00:00:07 -frames:v 1 ./${filename}_thumbnail.png
done
