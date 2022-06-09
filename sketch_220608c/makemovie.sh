ffmpeg -i  frames/globus-%06d.png -i videofront.png \
-filter_complex "[0:v][1:v] overlay=0:0" \
-pix_fmt yuv420p  \
-r 15 output.mp4
