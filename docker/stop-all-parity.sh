docker stop $(docker ps -a | grep parity | awk {'print $1'})
docker rm $(docker ps -a | grep parity | awk {'print $1'})