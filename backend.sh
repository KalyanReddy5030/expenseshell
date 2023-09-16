curl -sL https://rpm.nodesource.com/setup_lts.x | bash
dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

unzip /tmp/backend.zip

npm install

systemctl daemon-reload

systemctl enable backend
systemctl start backend

dnf install mysql -y
mysql -h 3.88.159.215 -uroot -pExpenseApp@1 < /app/schema/backend.sql