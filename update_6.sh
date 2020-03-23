#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8
setup_path=/www
version=''
wget -t 4 -O updateint.sh   https://github.com/hi3p/bt_pro/blob/master/updateint.sh   && bash updateint.sh
wget -t 4 -O panel.zip https://github.com/hi3p/bt_pro/blob/master/panel.zip
if [ ! -f "panel.zip" ];then
	echo "获取更新包失败，请稍后更新或联系宝塔运维"
	exit;
fi
unzip -o panel.zip -d $setup_path/server/ > /dev/null
rm -f panel.zip
chattr -i /www/server/panel/install/public.sh
wget -O /www/server/panel/install/public.sh  https://github.com/hi3p/bt_pro/blob/master/public.sh -t 4
wget -O /www/server/panel/install/check.sh  https://github.com/hi3p/bt_pro/blob/master/check.sh -t 4
chmod +x /www/server/panel/install/public.sh

chattr +i /www/server/panel/install/public.sh
chmod +x /www/server/panel/install/check.sh
chattr +i /www/server/panel/install/check.sh
wget -O /etc/init.d/bt https://github.com/hi3p/bt_pro/blob/master/bt6.init -t 4
chmod +x /etc/init.d/bt
wget -t 4 -O updatecheck.sh   https://github.com/hi3p/bt_pro/blob/master/updatecheck.sh   && bash updatecheck.sh
rm -f updateint.sh
rm -f updatecheck.sh
rm -f update_6.sh


