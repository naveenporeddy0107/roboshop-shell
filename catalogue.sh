script_path=$(dirName $0)
source ${script_path}/common.sh
echo -e "\e[32m>>>>>>>>>>>>> Configuring node js repos <<<<<<<<<<<<<<<<< \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m>>>>>>>>>>> installing node js >>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[32m>>>>>>>>>>> adding a user>>>>>>>\e[0m"

useradd ${app_user}
echo -e "\e[32m>>>>>>>>>>> making a directory>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m>>>>>>>>>>> downloding catalogue source code>>>>>>>\e[0m"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e "\e[32m>>>>>>>>>>> switching to app folder>>>>>>>\e[0m"

cd /app
echo -e "\e[32m>>>>>>>>>>> unzipping catalogue source code>>>>>>>\e[0m"

unzip /tmp/catalogue.zip

echo -e "\e[32m>>>>>>>>>>> Installing node tool>>>>>>>\e[0m"

npm install
echo -e "\e[32m>>>>>>>>>>> copying catalogue service file>>>>>>>\e[0m"

cp ${script_path}/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m>>>>>>>>>>> system ctl >>>>>>>\e[0m"

systemctl daemon-reload
echo -e "\e[32m>>>>>>>>>>> enabling catalogue  >>>>>>>\e[0m"

systemctl enable catalogue
echo -e "\e[32m>>>>>>>>>>> restarting catalogue service >>>>>>>\e[0m"

systemctl restart catalogue
echo -e "\e[32m>>>>>>>>>>> configuring mongodb repos>>>>>>>\e[0m"

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m>>>>>>>>>>> installing mongodb >>>>>>>\e[0m"

yum install mongodb-org-shell -y
echo -e "\e[32m>>>>>>>>>>> installing mongodb schema >>>>>>>\e[0m"

mongo --host mongo.naveendevops.tech </app/schema/catalogue.js
