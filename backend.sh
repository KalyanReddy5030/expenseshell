curl -sL https://rpm.nodesource.com/setup_lts.x | bash

rm -rf /etc/systemd/system/backend.service
dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service
useradd expense

rm-rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

unzip /tmp/backend.zip

npm install

systemctl daemon-reload

systemctl enable backend
systemctl start backend

dnf install mysql -y      
mysql -h 172.31.20.104 -uroot -pExpenseApp@1 < /app/schema/backend.sql