# Teamspeak-server

Salt module for automatically installing teamspeak3 server.

Installing:

This installation guide expects you to already have a working salt minion-master infrastructure.

Everything is done on the master client, first create a directory for the teamspeak salt module with sudo mkdir -p /srv/salt/teamspeak/. 
Then create a init.sls inside the teamspeak directory, and copy the contents of the init.sls file included in this repository into your init.sls file.
Then create a ts3server.service file into the teamspeak directory and copy the contents of the ts3server.service file into the matching file.

After that you can run the salt state with the sudo salt '*' state.apply teamspeak command, then you should be able to connect to the teamspeak 3 server using the 
minions ip address. This only works between the host computer and the virtual machines.

