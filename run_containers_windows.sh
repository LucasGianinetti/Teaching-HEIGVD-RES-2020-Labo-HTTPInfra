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

			staticOne=$(docker run -d --name static1 res/apache_php)
      dynamicOne=$(docker run -d --name dynamic1 res/express_students)
			staticTwo=$(docker run -d --name static2 res/apache_php)
			dynamicTwo=$(docker run -d --name dynamic2 res/express_students)

			static_IP1=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $staticOne)
      static_IP2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $staticTwo)
      dynamic_IP1=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $dynamicOne)
      dynamic_IP2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $dynamicTwo)

			#Finally we run the proxy with the needed IPAddresses
			docker run -d -e STATIC_APP_1=$static_IP1:80 -e STATIC_APP_2=$static_IP2:80 -e DYNAMIC_APP_1=$dynamic_IP1:3000 -e DYNAMIC_APP_2=$dynamic_IP2:3000 -p 8080:80 --name reverse_proxy res/apache_reverse_proxy;

			echo -e "\n";
			docker ps;

			echo -e "\nDone!";
			break;;
		
		No )
			echo -e "\nNothing done!";
			exit;;
	esac
done



