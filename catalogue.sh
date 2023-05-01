script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=catalogue
func_nodejs
echo -e "\e[32m>>>>>>>>>>> configuring mongodb repos>>>>>>>\e[0m"

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m>>>>>>>>>>> installing mongodb >>>>>>>\e[0m"

yum install mongodb-org-shell -y
echo -e "\e[32m>>>>>>>>>>> installing mongodb schema >>>>>>>\e[0m"

mongo --host mongo.naveendevops.tech </app/schema/catalogue.js
