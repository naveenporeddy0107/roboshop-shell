script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
sql_password=$1
yum install maven -y
useradd ${app_user}
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
rm -rf /app
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar

yum install mysql -y
mysql -h sql.naveendevops.tech -uroot -p${sql_password} < /app/schema/shipping.sql

systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping