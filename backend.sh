source common.sh
component=backend

echo install nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file

echo install nodejs
dnf install nodejs -y >>$log_file

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo Add Application user
useradd expense

echo removing app content
rm -rf /app >>$log_file

mkdir /app
cd /app
download_and_extract

echo Download dependencies
npm install >>$log_file
echo start backend service
systemctl daemon-reload >>$log_file

systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo install mysql client
dnf install mysql -y >>$log_file

echo Load Schema
mysql -h mysql.kalyanreddy5030.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file