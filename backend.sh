source common.sh
component=backend

echo install nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
echo $?

echo install nodejs
dnf install nodejs -y &>>$log_file
echo $?

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo Add Application user
useradd expense
echo $?

echo removing app content
rm -rf /app &>>$log_file
echo $?

mkdir /app
cd /app
download_and_extract

echo Download dependencies
npm install &>>$log_file
echo $?
echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?

echo install mysql client
dnf install mysql -y &>>$log_file
echo $?

echo Load Schema
mysql -h mysql.kalyanreddy5030.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?
#At installing nodejs and npm install line even we are saying to send the all code to log_file=/tmp/expense.log by
# this it won't be displaying o/p in terminal but still it is displaying to avoid this will learn
# Outpu redirector (>,1>,2> , &>)
#>,1> - o/p , 2> -error (not an like error since eventhough we shifted our o/p to different file
#since in terminal we are getting o/p data so it like error for OS

# check D75-2023-09-08-SESSION-16 to know the difference in notion
#so in all service files we are replacing >>$log_file to &>>$log_file