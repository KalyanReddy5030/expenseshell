source common.sh
echo installing nginx
dnf install nginx -y >>$log_file

echo placing expense conf file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo Removing old content
rm -rf /usr/share/nginx/html/*

echo downloading frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file


cd /usr/share/nginx/html
echo extracting frontend code
unzip /tmp/frontend.zip >>$log_file

echo starting nginx service
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file