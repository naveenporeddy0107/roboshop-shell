app_user=roboshop

func_nodejs() {
echo -e "\e[32m>>>>>>>>>>> configuring node js repo files>>>>>>>\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m>>>>>>>>> install node js<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[32m>>>>>>>>> adding a user<<<<<<<\e[0m"

useradd ${app_user}
echo -e "\e[32m>>>>>>>>> Extracting cart source code<<<<<<<\e[0m"
rm -rf /app
mkdir /app
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
cd /app
unzip /tmp/${component}.zip
echo -e "\e[32m>>>>>>>>> install node js<<<<<<<\e[0m"

npm install

echo -e "\e[32m>>>>>>>>> copy service file<<<<<<<\e[0m"

cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
echo -e "\e[32m>>>>>>>>> cart service restart<<<<<<<\e[0m"

systemctl daemon-reload
systemctl enable ${component}
systemctl restart ${component}

}