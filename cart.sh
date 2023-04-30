script_path=$(dirName $0)
source ${script_path}/common.sh
echo -e "\e[32m>>>>>>>>>>> configuring node js repo files>>>>>>>\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m>>>>>>>>> install node js<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[32m>>>>>>>>> adding a user<<<<<<<\e[0m"

useradd ${app_user}
echo -e "\e[32m>>>>>>>>> Extracting cart source code<<<<<<<\e[0m"

mkdir /app
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip
echo -e "\e[32m>>>>>>>>> install node js<<<<<<<\e[0m"

npm install

echo -e "\e[32m>>>>>>>>> copy service file<<<<<<<\e[0m"

cp script_path/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m>>>>>>>>> cart service restart<<<<<<<\e[0m"

systemctl daemon-reload
systemctl enable cart
systemctl restart cart
