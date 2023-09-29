source common.sh

echo Disabling MYSQL 8 version
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo copying mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo install mysql server
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo start mysql service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi