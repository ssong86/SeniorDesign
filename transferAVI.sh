 lockdir=/myscript.lock
 if mkdir "$lockdir" #mkdir is atomic, thus use as a locking mechanism (http://stackoverflow.com/questions/185451/quick-and-dirty-way-to-ensure-only-one-instance-of-a-shell-script-is-running-at/731634#731634)
 then
    echo >&2 "successfully acquired lock"
    eval 'rsync -av --inplace --rsh="sshpass -p 'Dhrmaehd216' ssh -o StrictHostKeyChecking=no -l ssong86" fullgame.avi ssong86@sangwon.vip.gatech.edu:/var/videoProject/seniordesign/'
     # Remove lockdir when the script finishes, or when it receives a signal
    trap 'rm -rf "$lockdir"' 0 1 2 15  # remove directory when script finishes or upon crashing
	
    # Optionally create temporary files in this directory, because
    # they will be removed automatically:
    tmpfile=$lockdir/filelist

 else
     echo >&2 "cannot acquire lock, giving up on $lockdir"
     exit 0
 fi