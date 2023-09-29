# To apply the dry concept across the scripts, the below line will able to get changed accross the scripts
# by just loading this data in all the service files by giving source common.sh
#By this at sometime if we need to change to different path the location then we can just change here
log_file=/tmp/expense.log

# this is to more dry the content having in different scripts the repititive script
# This downloading and extracting data has been repititve in all service files.

download_and_extract(){
  #in below line the front end was hardcoded so to avoid this we are giving local variable in
  #frontend.sh as component=frontend and to execute we give as $component
echo downloading $component code
curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi

echo extracting $component code
unzip /tmp/$component.zip >>$log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
  else
  echo -e "\e[31mFAILED\e[0m"
  exit 1
fi
}