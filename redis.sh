echo -e "\e[32m >>>>>>>>> configuring redis repo<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
echo -e "\e[32m >>>>>>>>>Installing redis<<<<<<<<\e[0m"

yum install redis -y
echo -e "\e[32m >>>>>>>>>Changing the Config<<<<<<<<\e[0m"

sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf
echo -e "\e[32m >>>>>>>>> Start Redis<<<<<<<<\e[0m"

systemctl enable redis
systemctl start redis