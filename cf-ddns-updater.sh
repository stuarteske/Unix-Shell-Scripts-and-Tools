#!/bin/sh
# modified by jfro from http://www.cnysupport.com/index.php/linode-dynamic-dns-ddns-update-script
# Update: changed because the old IP-service wasn't working anymore
# Uses curl to be compatible with machines that don't have wget by default
# modified by Ross Hosman for use with cloudflare.
#
# Place at:
# /usr/local/bin/cf-ddns.sh
# run `crontab -e` and add next line:
# 0 */5 * * * * /usr/local/bin/cf-ddns.sh >/dev/null 2>&1
#
# Get subdomain record id:
# curl https://www.cloudflare/com/api_json.html \
#   -d 'a=rec_load_all' \
#   -d 'tkn==your-api-key' \
#   -d 'email=your-account-email' \
#   -d 'z=your-domain-name.com'
# Use the "rec-id"

cfkey=your-api-key
cfuser=your-account-email
cfhost=your-sub-domain #example e.g. ftp, mail, www
cfid=174343572 #subdomain record id. get with curl script above
domain=your-domain-name #examnple.com

WAN_IP=`curl -s http://icanhazip.com`
if [ -f $HOME/.wan_ip-cf.txt ]; then
        OLD_WAN_IP=`cat $HOME/.wan_ip-cf.txt`
else
        echo "No file, need IP"
        OLD_WAN_IP=""
fi

if [ "$WAN_IP" = "$OLD_WAN_IP" ]; then
        echo "IP Unchanged"
else
        echo $WAN_IP > $HOME/.wan_ip-cf.txt
        echo "Updating DNS to $WAN_IP"
         curl https://www.cloudflare.com/api_json.html \
          -d a=rec_edit \
          -d tkn=$cfkey \
          -d email=$cfuser \
          -d z=$domain \
          -d id=$cfid \
          -d type=A \
          -d name=$cfhost \
          -d ttl=1 \
          -d "content=$WAN_IP" > /dev/null
fi