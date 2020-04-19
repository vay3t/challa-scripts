function check_form(){ 
	curl $1 -s | grep -i "<form" | grep -i 'method="post"' &> /dev/null
	if [ $? -eq 0 ]; then 
		echo $1; 
	fi;
}
export -f check_form 
sort -u links.txt | parallel -j10 check_form