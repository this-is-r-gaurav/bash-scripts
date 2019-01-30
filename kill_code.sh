#!/bin/sh
while true
do   
	process_id=`/bin/ps -fu $USER| grep "terminator" | grep -v "grep" | awk '{print $2}' | tr -d '\n'`

	if [  -n "$process_id" ]
	then
		child_processes=`/bin/ps --ppid $process_id -o pid | grep "[0-9]" | tr '\n' ' '`
		child_process=`/bin/ps --no-headers -o pid --ppid=$process_id | wc -w`
		arr=($child_processes)
		#echo `/bin/kill $child_processes`
		if [ ${#arr[@]} -gt 2 ]
		then
			process_to_kill=` expr ${#arr[@]} - 2 `
			while [  $process_to_kill -ne 0 ]
			do
				echo `/bin/kill ${arr[$process_to_kill]}`
				process_to_kill=`expr $process_to_kill - 1` 
	        done
		else
			echo "Currently Less than Two Instances active"
		fi
	else
		echo "No CODE Running"
	fi
	sleep 2
done