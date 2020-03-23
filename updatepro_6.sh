#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8
if [ ! -d /www/server/panel/BTPanel ];then
	echo "============================================="
	echo "错误, 5.x不可以使用此命令升级!"
	echo "5.9平滑升级到6.0的命令：curl http://download.bt.cn/install/update_to_6.sh|bash"
	exit 0;
fi
setup_path=/www
version=''
wget -O updateint.sh   https://github.com/hi3p/bt_pro/blob/master/updateint.sh   && bash updateint.sh

wget -T 5 -O panel.zip https://github.com/hi3p/bt_pro/blob/master/panel.zip
if [ ! -f "panel.zip" ];then
	echo "获取更新包失败，请稍后更新或联系宝塔运维"
	exit;
fi
unzip -o panel.zip -d $setup_path/server/ > /dev/null
rm -f panel.zip
rm -f /etc/init.d/bt
wget -O /etc/init.d/bt https://github.com/hi3p/bt_pro/blob/master/bt6.init -T 10
chmod +x /etc/init.d/bt
wget -O updatecheck.sh   https://github.com/hi3p/bt_pro/blob/master/updatecheck.sh   && bash updatecheck.sh
rm -f updateint.sh
rm -f updatecheck.sh
panel_path='/www/server/panel'
rm -f $panel_path/*.pyc $panel_path/class/*.pyc
sleep 1 && service bt restart > /dev/null 2>&1 &
echo "====================================="
echo "service install ok";
rm -f updatepro_6.sh


