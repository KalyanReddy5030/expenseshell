source common.sh

echo Disabling MYSQL 8 version
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
fi

echo copying mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo install mysql server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo start mysql service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo Setup root Password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
stat_check

#ExpenseApp@1 this was pwd usually we don't use in real time like this for my reference i have commented