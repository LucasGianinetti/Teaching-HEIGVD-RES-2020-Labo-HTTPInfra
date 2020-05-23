echo "Do you want to restart/start the containers ?";
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			#First we make sure to clean the containers if they are running/exited
			echo -e "\nKilling containers:";
			docker kill static1;
			docker kill static2;
			docker kill dynamic1;
			docker kill dynamic2;
			docker kill reverse_proxy;

			echo -e "\nRemoving containers:"
			docker rm static1;
			docker rm static2;
			docker rm dynamic1;
			docker rm dynamic2;
			docker rm reverse_proxy;


			#Then we run the static and dynamics containers
			echo -e "\nRunning containers:";

			docker run -d --name static1 res/apache_php;
                        docker run -d --name dynamic1 res/express_students;
			docker run -d --name static2 res/apache_php;
			docker run -d --name dynamic2 res/express_students;

			#We export their IPAddresses into environment variables
			export STATIC_APP_1="$(docker inspect static1 | grep '"IPAddress"' | grep -o -m 1 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')":80;
			export STATIC_APP_2="$(docker inspect static2 | grep '"IPAddress"' | grep -o -m 1 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')":80;
			export DYNAMIC_APP_1="$(docker inspect dynamic1 | grep '"IPAddress"' | grep -o -m 1 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')":3000;
			export DYNAMIC_APP_2="$(docker inspect dynamic2 | grep '"IPAddress"' | grep -o -m 1 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')":3000;

			#Finally we run the proxy with the needed IPAddresses 
			docker run -d -e STATIC_APP_1 -e STATIC_APP_2 -e DYNAMIC_APP_1 -e DYNAMIC_APP_2 -p 8080:80 --name reverse_proxy res/apache_reverse_proxy;
			
			echo -e "\n";
			docker ps;

			echo -e "\nDone!";
			break;;
		
		No )
			echo -e "\nNothing done!";
			exit;;
	esac
done



