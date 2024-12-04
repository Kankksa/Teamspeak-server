paketit:
  pkg.installed:
    - pkgs:
      - wget

teamspeakuser:
  user.present:
    - name: teamspeak
    - shell: /bin/bash
    - home: /home/teamspeak

teamspeakhome:
  file.directory:
    - name: /home/teamspeak/teamspeak3-server
    - user: teamspeak
    - group: teamspeak
    - mode: 0755

teamspeakdownload:
  cmd.run:
    - name: wget -q https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_linux_amd64-3.13.7.tar.bz2
    - unless: test -f  /home/teamspeak/teamspeak3-server/teamspeak3-server_linux_amd64/ts3server_startscript.sh
    - cwd: /home/teamspeak
    - user: teamspeak

teamspeakextract:
  archive.extracted:
    - name: /home/teamspeak/teamspeak3-server
    - source: /home/teamspeak/teamspeak3-server_linux_amd64-3.13.7.tar.bz2
    - archive_format: tar
    - user: teamspeak
    - group: teamspeak
    - if_missing: /home/teamspeak/teamspeak3-server/teamspeak3-server_linux_amd64/ts3server_startsctript.sh

teamspeaklicense:
  file.managed:
    - name: /home/teamspeak/teamspeak3-server/teamspeak3-server_linux_amd64/.ts3server_license_accepted
    - user: teamspeak
    - group: teamspeak
    - mode: 0644

teamspeakservice:
  file.managed:
    - name: /lib/systemd/system/ts3server.service
    - source: salt://teamspeak/ts3server.service
    - mode: 0644

systemdreload:
  cmd.wait:
    - name: systemctl daemon-reload
    - watch:
      - file: teamspeakservice

ts3server.service:
  service.running:
    - enable: True
    - watch:
      - cmd: systemdreload
