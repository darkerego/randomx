#!/bin/bash
# Random password generator. Originally by jbsnake, modified by crouse to use Upper case letters as well.
# Now also does error checking and fails if the input isn't numerical integers or if no input is given at all.
# Modified by Darkerego to save output with description so you can remember what the password is for.
# For obvious security reasons, this is better managed as root.
if [ "$(id -u)" != "0" ]; then
   echo "Run it as root." 1>&2
   exit 1
fi

if [[ -z "$1" || $1 = *[^0-9]* ]];
  then
   echo " ";
   echo "      ######### COMMAND FAILED ########## ";
   echo "      USAGE: $0 passwordlength";
   echo "      EXAMPLE: $0 10";
   echo "      Creates a random password 10 chars long.";
   echo "      ######### COMMAND FAILED ########## ";echo " ";
   exit
  else
   if [[ "$1" -lt "6" ]]
   then echo "Your password is less than 6 characters in length."
         echo "This is a security risk. Suggested length is 6 characters or longer !"
   fi
   RIGHTNOW=$(date +"%R %x")
   pwdlen=$1
   char=(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V X W Y Z)
   max=${#char[*]}
   for i in `seq 1 $pwdlen`
      do
           let "rand=$RANDOM % 62"
      str="${str}${char[$rand]}"
      done
   echo $str ##| tee -a passwords
fi
echo 'Enter a password description'
read pwinfo; echo $RIGHTNOW : $pwinfo : $str >> ~/.passwords
echo 'Warning: output saved to passwords file'
exit
