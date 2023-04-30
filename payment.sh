source common.sh
yum install python36 gcc python3-devel -y
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service
useradd ${app_user}
rm -rf /app
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip
pip3.6 install -r requirements.txt
systemctl daemon-reload
systemctl enable payment
systemctl restart payment