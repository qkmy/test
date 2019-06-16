#!bin/bash
#Author: mooncn
#Blog: myxw.ml
#Date: 20190615
#Purpose: one key for replace the SSH Authorization method .
setuppublickey()
{
rpm -ivh http://xb1028-10066197.cos.myqcloud.com/1028/epel-release-7-5.noarch.rpm
rpm -ivh http://xb1028-10066197.cos.myqcloud.com/1028/remi-release-7.rpm
yum install nload -y
cd /root
mkdir .ssh
cd .ssh
wget http://myxw.ml/cackey.pub
cat cackey.pub > authorized_keys
chmod 600 authorized_keys
chmod 700 ~/.ssh
rm -rf cackey.pub
echo "The Pub Key File Is Property Placed!"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak


}

enablekeylogin()
{
sed -i '/#PubkeyAuthentication no/cPubkeyAuthentication yes' /etc/ssh/sshd_config
echo '密匙登录开启成功'
echo '正在重启SSH服务'
sleep 3

service sshd restart
echo "请确认密匙登录成功后关闭密码登录"

}

disablepasslogin()
{
sed -i '/#PasswordAuthentication yes/cPubkeyAuthentication no' /etc/ssh/sshd_config
service sshd restart

}
restorebackup()
{
    rm -rf /etc/ssh/sshd_config
    cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
    service sshd restart
    echo "Default Configuration File Has Been Recovery"
}
echo "********Please Wait ...........*********"
echo "****Welcome To Use The Tool****"
echo "******* BLOG: myxw.ml *********"
sleep 3
echo "请输入选项:"
echo "1 配置公匙文件"
echo "2 开启密匙登录"
echo "3 关闭密码登录"
echo "4 Restore Backup"
read x
case $x in
1)
setuppublickey
;;
2)
enablekeylogin
;;
3)
disablepasslogin
;;
4)
restorebackup
;;
*)
echo "输入错误，请重新执行脚本"
exit;
;;
