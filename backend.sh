source common.sh
component=backend #local variable backend

echo install nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo install nodejs
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo Add Application user
useradd expense
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo removing app content
rm -rf /app &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

mkdir /app
cd /app
download_and_extract

echo Download dependencies
npm install &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo install mysql client
dnf install mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo Load Schema
mysql -h mysql.kalyanreddy5030.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi
#At installing nodejs and npm install line even we are saying to send the all code to
# log_file=/tmp/expense.log by
# this it won't be displaying o/p in terminal but still it is displaying to avoid this will learn
# Outpu redirector (>,1>,2> , &>)
#>,1> - o/p , 2> -error (not an like error since eventhough we shifted our o/p to different file
#since in terminal we are getting o/p data so it like error for OS

# check D75-2023-09-08-SESSION-16 to know the difference in notion
#so in all service files we are replacing >>$log_file to &>>$log_file

#exit- if we give simply as exit and if we execute in terminal then it shows as error in red colour
#but when we give echo $? it states as 0 even it is having error,by this user thinks
# there was no error eventhough having error,To Avoid this
#we are using "exit1"-By this if it is having error and if we give echo $1 it shows 1 states error