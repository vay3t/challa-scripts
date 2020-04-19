
for port in {1..65535}; do
	timeout 1 bash -c "echo > /dev/tcp/$1/$port" &> /dev/null &&  echo "Port $port -- OPEN" &
done; wait