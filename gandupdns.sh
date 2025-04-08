#!/bin/sh
#
# gandupdns.sh - A script that updates your subdomain.example.com A record with a current one for your dynamic IP
# I wrote this out of frustration for the os-ddclient currently shipping with OPNsense.
# I could not get it to work. Could've been a skill issue.
# You can run this on an ad-hoc basis, or install the accompanying action file and set it up as a cron job through the webui
# author: conorabc
FQDN="example.com"

# Which subdomain to update. can be * for wildcard
SUBD="subdomain"

DNS_TTL="300"

# YOU MUST GENERATE A PAT TOKEN AND PASTE IT BELOW
AUTH="Authorization: Bearer YOUR_PAT_TOKEN"
URL="https://api.gandi.net/v5/livedns/domains/${FQDN}/records/${SUBD}/A"

logger -t gandupdns "Starting Gandi DNS Update"

CURIP=$(curl -s https://ipv4.icanhazip.com)
CURIP=$(echo "$CURIP" | tr -d '[:space:]')

logger -t gandupdns "Our current public IPv4 IP is $CURIP"
logger -t gandupdns "We are updating $SUBD.$FQDN to point to $CURIP"



DATA=$(cat <<EOF
{
  "rrset_values": ["${CURIP}"],
  "rrset_ttl": ${DNS_TTL}
}
EOF
)
logger -t gandupdns "PUT-ing update request..."


RESPONSE=$(curl -s -X PUT \
  -H "Content-Type: application/json" \
  -H "$AUTH" \
  -d "$DATA" \
  "$URL")

logger -t gandupdns "Update request PUT-ed!"
logger -t gandupdns "API response: $RESPONSE"
logger -t gandupdns "gandupdns.sh finished."

