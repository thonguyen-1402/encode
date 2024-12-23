declare -a scenes
scenes=("longdress" "soldier" "redandblack" "loot")
declare -a frames
frames=(15 30 45 75 90 150) #segment duration 0.5 1 1.5 2 2.5 3 5

total=300  # Total frames

# Declare the startnum array
declare -a startnum
startnum[0]=1051
startnum[1]=536
startnum[2]=1450
startnum[3]=1000

for i in $1; do
    for j in {0..5}; do
        sc=$((total/frames[j]))
        echo "Scene: ${scenes[$i]}, Frames: ${frames[$j]}, Segments: $sc"
        for ((k = 0; k < sc; k++)); do
            start_frame_number=$(( ${startnum[$i]} + (${frames[$j]} * k) ))
            ./bin/PccAppEncoder \
                --configurationFolder=./cfg/ \
                --config=./cfg/common/ctc-common.cfg \
                --config=./cfg/condition/ctc-random-access.cfg \
                --config=./cfg/sequence/${scenes[$i]}_vox10.cfg \
                --startFrameNumber=$start_frame_number \
                --config=./cfg/rate/ctc-r2.cfg \
                --frameCount=${frames[$j]} \
                --compressedStreamPath=./ENCODE/SCENE_${scenes[$i]}_random/${scenes[$i]}_${frames[$j]}_seg\#${k}.bin \
                --uncompressedDataPath=./${scenes[$i]}/src/Ply/${scenes[$i]}_vox10_%04d.ply
        done
    done
done
#the backlash is used to say that the command continue in the next line 