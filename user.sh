script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=user
func_nodejs
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongo.naveendevops.tech </app/schema/user.js
