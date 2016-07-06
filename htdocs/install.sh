#!/bin/bash
<<ENDOFSIGSTART
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ENDOFSIGSTART

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin

echo
echo '*** ZeroTier One Linux Quick Install'
echo
echo '*** Supported targets for this script:'
echo '***    MacOS (10.7+) on x86_64 (installs Mac .pkg)'
echo '***    Linux / Debian (jessie or newer) on i386, x86_64, and armhf (Raspbian)'
echo '***    Linux / Ubuntu (trusty or newer) on i386 and x86_64'
echo '***    Linux / SuSE (12+) on i386 and x86_64'
echo '***    Linux / CentOS (6+) on i386 and x86_64'
echo '***    Linux / Fedora (22+) on i386 and x86_64'
echo '***    Linux / Amazon (2016.03+) on x86_64'
echo
echo '*** Please report problems to contact@zerotier.com and we will try to fix ASAP!'
echo

SUDO=
if [ "$UID" != "0" ]; then
	if [ -e /usr/bin/sudo -o -e /bin/sudo ]; then
		SUDO=sudo
	else
		echo '*** This quick installer script requires root privileges.'
		exit 0
	fi
fi

# MacOS
if [ -e /usr/bin/uname -a "`/usr/bin/uname -s`" = "Darwin" ]; then
	echo '*** Detected MacOS / Darwin, downloading and installing Mac .pkg...'
	$SUDO rm -f "/tmp/ZeroTier One.pkg"
	curl -s https://download.zerotier.com/dist/ZeroTier%20One.pkg >"/tmp/ZeroTier One.pkg"
	$SUDO installer -pkg "/tmp/ZeroTier One.pkg" -target /

	echo
	echo '*** Waiting for identity generation...'

	while [ ! -f "/Library/Application Support/ZeroTier/One/identity.secret" ]; do
		sleep 1
	done

	echo
	echo "*** Success! You are connected to port `cat '/Library/Application Support/ZeroTier/One/identity.public' | cut -d : -f 1` of Earth's planetary smart switch."
	echo

	exit 0
fi

if [ -f /usr/sbin/zerotier-one ]; then
	echo '*** ZeroTier One appears to already be installed.'
	exit 0
fi

rm -f /tmp/zt-gpg-key
echo '-----BEGIN PGP PUBLIC KEY BLOCK-----' >/tmp/zt-gpg-key
cat >>/tmp/zt-gpg-key << END_OF_KEY
Comment: GPGTools - https://gpgtools.org

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
=JgAv
END_OF_KEY
echo '-----END PGP PUBLIC KEY BLOCK-----' >>/tmp/zt-gpg-key

echo '*** Detecting Linux Distribution'
echo

if [ -f /etc/debian_version ]; then
	dvers=`cat /etc/debian_version | cut -d '.' -f 1 | cut -d '/' -f 1`
	$SUDO rm -f /tmp/zt-sources-list
	if [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F trusty`" ]; then
		echo '*** Found Ubuntu "trusty", creating /etc/apt/sources.list.d/zerotier.list'
		echo 'deb http://download.zerotier.com/debian/trusty trusty main' >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F wily`" ]; then
		echo '*** Found Ubuntu "wily", creating /etc/apt/sources.list.d/zerotier.list'
		echo 'deb http://download.zerotier.com/debian/wily wily main' >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F xenial`" ]; then
		echo '*** Found Ubuntu "xenial", creating /etc/apt/sources.list.d/zerotier.list'
		echo 'deb http://download.zerotier.com/debian/xenial xenial main' >/tmp/zt-sources-list
	elif [ "$dvers" = "8" -o "$dvers" = "jessie" ]; then
		echo '*** Found Debian "jessie" (or similar), creating /etc/apt/sources.list.d/zerotier.list'
		echo 'deb http://download.zerotier.com/debian/jessie jessie main' >/tmp/zt-sources-list
	elif [ "$dvers" = "9" -o "$dvers" = "stretch" -o "$dvers" = "10" -o "$dvers" = "sid" ]; then
		echo '*** Found Debian "stretch" or "sid" (or similar), creating /etc/apt/sources.list.d/zerotier.list'
		echo 'deb http://download.zerotier.com/debian/stretch stretch main' >/tmp/zt-sources-list
	else
		echo "*** FAILED: unrecognized or ancient distribution: $dvers"
		exit 1
	fi

	$SUDO mv -f /tmp/zt-sources-list /etc/apt/sources.list.d/zerotier.list
	$SUDO chown 0 /etc/apt/sources.list.d/zerotier.list
	$SUDO chgrp 0 /etc/apt/sources.list.d/zerotier.list
	$SUDO apt-key add /tmp/zt-gpg-key

	echo
	echo '*** Installing zerotier-one package...'

	cat /dev/null | $SUDO apt-get update
	cat /dev/null | $SUDO apt-get install -y zerotier-one
elif [ -f /etc/SuSE-release -o -f /etc/suse-release ]; then
	echo '*** Found SuSE, adding zypper YUM repo...'
	cat /dev/null | $SUDO zypper addrepo -t YUM -g http://download.zerotier.com/redhat/el/7 zerotier
	cat /dev/null | $SUDO rpm --import /tmp/zt-gpg-key

	echo
	echo '*** Installing zeortier-one package...'

	cat /dv/null | $SUDO zypper install -y zerotier-one
elif [ -d /etc/yum.repos.d ]; then
	baseurl='http://download.zerotier.com/redhat/el/6'
	if [ -n "`cat /etc/redhat-release 2>/dev/null | grep -i fedora`" ]; then
		echo "*** Found Fedora, creating /etc/yum.repos.d/zerotier.repo"
		baseurl='http://download.zerotier.com/redhat/fc/22'
	elif [ -n "`cat /etc/redhat-release 2>/dev/null | grep -i centos`" -o -n "`cat /etc/redhat-release 2>/dev/null | grep -i enterprise`" ]; then
		echo "*** Found RHEL/CentOS, creating /etc/yum.repos.d/zerotier.repo"
		baseurl='http://download.zerotier.com/redhat/el/$releasever'
	elif [ -n "`cat /etc/system-release 2>/dev/null | grep -i amazon`" ]; then
		echo "*** Found Amazon (CentOS/RHEL based), creating /etc/yum.repos.d/zerotier.repo"
		baseurl='http://download.zerotier.com/redhat/amzn1/2016.03'
	else
		echo "*** Found unknown yum-based repo, using el/6 for max compatibility, creating /etc/yum.repos.d/zerotier.repo"
	fi

	$SUDO rpm --import /tmp/zt-gpg-key

	$SUDO rm -f /tmp/zerotier.repo
	echo '[zerotier]' >/tmp/zerotier.repo
	echo 'name=ZeroTier, Inc. RPM Release Repository' >>/tmp/zerotier.repo
	echo "baseurl=$baseurl" >>/tmp/zerotier.repo
	echo 'enabled=1' >>/tmp/zerotier.repo
	echo 'gpgcheck=1' >>/tmp/zerotier.repo

	$SUDO mv -f /tmp/zerotier.repo /etc/yum.repos.d/zerotier.repo
	$SUDO chown 0 /etc/yum.repos.d/zerotier.repo
	$SUDO chgrp 0 /etc/yum.repos.d/zerotier.repo

	echo
	echo '*** Installing zerotier-one package...'

	if [ -e /usr/bin/dnf ]; then
		cat /dev/null | $SUDO dnf install -y zerotier-one
	else
		cat /dev/null | $SUDO yum install -y zerotier-one
	fi
fi

$SUDO rm -f /tmp/zt-gpg-key

if [ ! -e /usr/sbin/zerotier-one ]; then
	echo
	echo '*** Package installation failed! Unfortunately there may not be a package'
	echo '*** for your architecture or distribution. For the source go to:'
	echo '*** https://github.com/zerotier/ZeroTierOne'
	echo
	exit 1
fi

echo
echo '*** Enabling and starting zerotier-one service...'

if [ -e /usr/bin/systemctl -o -e /usr/sbin/systemctl -o -e /sbin/systemctl -o -e /bin/systemctl ]; then
	$SUDO systemctl enable zerotier-one
	$SUDO systemctl start zerotier-one
	if [ "$?" != "0" ]; then
		echo
		echo '*** Package installed but cannot start service! You may be in a Docker'
		echo '*** container or using a non-standard init service.'
		echo
		exit 1
	fi
else
	if [ -e /sbin/update-rc.d -o -e /usr/sbin/update-rc.d -o -e /bin/update-rc.d -o -e /usr/bin/update-rc.d ]; then
		$SUDO update-rc.d zerotier-one defaults
	else
		$SUDO chkconfig zerotier-one on
	fi
	$SUDO /etc/init.d/zerotier-one start
fi

echo
echo '*** Waiting for identity generation...'

while [ ! -f /var/lib/zerotier-one/identity.secret ]; do
	sleep 1
done

echo
echo "*** Success! You are connected to port `cat /var/lib/zerotier-one/identity.public | cut -d : -f 1` of Earth's planetary smart switch."
echo

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJXfIqCAAoJEBZXGYgj5SphrkwQALKobKttsmSD3wn0WaDLAcmC
Thnld3Cb10rG+d8wBU4ig1viiPqPkuvQxpXkiD7fSS3n49Htp1vug3GhYQLniFhY
LmkOFOyxvYcbj6S0oHMeJzr7uQ2QQYEM5mVh7CCMQcXU0i76JXG0p8QNixTeBLe3
6dvSOSzhhIKpwTOFEQCJkDcmox7cZH8Pf5zRY9Lgr2+DNQbhH/pwojXWQB3Ro84g
qausCOY96Nff7RVC1G4yUQbdBueuYG45KaxDOfGEjDQLwgXZXCT9uYS0oFAzsquj
9on9N3vt0rcSmHXpE2JHnfvuwxOfXeKfdpOOguK45FYxphlOTYAHbSwno6m58dwR
bOIlymT2nCMfs1K9KGs5TqYpheOKo1bwe/htW4UMnUXRBND8LnWlgtANrk51DpsW
f4qhowIBoB7Ngd7bYnH5EtqQjeHHB/aJjVK4e0ylnfIJfTmN813iTOdklFOdIjaI
BLlAPF1JWyD/3ooawtjSCBgOpqUYJFdkKFGQdUXqcmsqp/kNa94CfLK+stLI/Hyu
rNx3wCUwDZFQl6VbSJw3/wnLB3H7+8/MW9+hNa1Q8pbGjabuuO4tI3bNNUNWxXKL
DXQrIGYxwgBwCbmEPQeCUKSbTG5+xXRyDOR3kJr9ItbkAYW5LO6P9oQgMXz8Q7xW
qnRyMAIARM7lQPf6x4un
=y6Ag
-----END PGP SIGNATURE-----