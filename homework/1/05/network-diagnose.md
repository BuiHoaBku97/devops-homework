sudo ss -tulpn | grep ':8080'
sudo kill -9 111

ping -c 4 10.0.1.20
curl -v --connect-timeout 3 telnet://10.0.1.20:5432