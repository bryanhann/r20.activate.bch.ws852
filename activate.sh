here=$(dirname $(grealpath $0))
export VJOT=$here
function ws852 () {
    FOLDER_=/Volumes/WS-852/RECORDER/FOLDER_
    SCRIPT=${VJOT}/scripts/fix.py
    SAVECWD=${PWD}
    for xx in A B C D E; do
        cd ${FOLDER_}${xx} || continue
        python ${SCRIPT} .
        for fname in $(/bin/ls -1 *.ws852.mp3) ; do
             aws s3 mv ${fname} s3://bch.archive.voice/${fname}
        done
    done
    cd ${SAVECWD}
    return
}


