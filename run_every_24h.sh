time bash update_all.sh
echo $(date)
while sleep 43200; do time bash update_all.sh; echo $(date); done
