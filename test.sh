$count = 0
for i in $(say -v? | awk -F'  ' '{print $1}');
do
	'$count' = '$count' + 1
	words[$count]=$i
	echo $i
done
