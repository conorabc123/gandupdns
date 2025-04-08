Tested on OPNsense 24.7.12_4-amd64


place `gandupdns.sh` in `/usr/local/sbin/`


make it executable with `chmod +x /usr/local/sbin/gandupdns.sh`


place `actions_gandupdns.conf` in `/usr/local/opnsense/service/conf/actions.d/`


run `service configd restart`


add it to cron in the webui in `System-Settings-Cron`


once it runs, check its output in `System-Log Files-General` and search for `gandupdns`
