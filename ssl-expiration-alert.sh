#!/bin/bash
TELEGRAM_CHAT_ID="your_telegram_chat_id"
TELEGRAM_TOKEN="your_telegram_token"
DOMAINS="./domain.txt"
DAYS="30"

while read -r TARGET; do
  # Check Domain Target expires less than spesific Days
  ssldate=$(date -d "$(: | openssl s_client -connect "$TARGET":443 -servername "$TARGET" 2>/dev/null \
                                | openssl x509 -text \
                                | grep 'Not After' \
                                |awk '{print $4,$5,$7}')" '+%s');
  sslexpired=$(($(date +%s) + (86400*DAYS)));
  if [ "$sslexpired" -gt "$ssldate" ]; then
      TEXT=" # SSL EXPIRED # %0A Domain Name : $TARGET %0A SSL Validity Date : $(date -d @"$ssldate" '+%d-%m-%Y') %0A Expired in : $DAYS days"
      
      curl -s --data "text=$TEXT" --data "chat_id=$TELEGRAM_CHAT_ID" 'https://api.telegram.org/bot'$TELEGRAM_TOKEN'/sendMessage' > /dev/null
      echo "$TEXT"
	
  else
      echo "";
  fi;
done<"${DOMAINS}"
