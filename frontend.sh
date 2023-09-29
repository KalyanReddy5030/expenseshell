source common.sh
component=frontend
echo installing nginx
dnf install nginx -y &>>$log_file
echo $?

echo placing expense conf file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

echo Removing old content
rm -rf /usr/share/nginx/html/*
echo $?

cd /usr/share/nginx/html

download_and_extract

echo starting nginx service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?