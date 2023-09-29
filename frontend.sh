source common.sh
component=frontend  #local variable component
echo installing nginx
dnf install nginx -y &>>$log_file

if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo placing expense conf file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

echo Removing old content
rm -rf /usr/share/nginx/html/*
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi

cd /usr/share/nginx/html

download_and_extract

echo starting nginx service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILED
fi