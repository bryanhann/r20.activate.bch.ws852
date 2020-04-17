R20_ws852_script=$(dirname $(grealpath $0))/scripts/fix.py
R20_ws852_prefix=/Volumes/WS-852/RECORDER/FOLDER_

function r20_ws852 () {
    local cwd=${PWD}
    for xx in A B C D E; do
        # Attempt to enter the folder on the device itself.
        cd ${R20_ws852_prefix}${xx} || continue
        # In that folder, remane files as appropriately.
        python ${R20_ws852_script} .
        # Now iter through the names in the folder...
        for fname in $(/bin/ls -1 *.ws852.mp3) ; do
            #... and move them to AWS as appropriate.
            aws s3 mv ${fname} s3://bch.archive.voice/${fname}
        done
    done
    cd ${cwd}
}


