#!/usr/bin/fish
#
# First load each rss file one at a time

for t in tradingecon youtube podcasts govinfo
  echo $t
  cat /root/$t.txt >> /root/.newsboat/urls
  newsboat --log-level 5 --log-file /dev/stdout --url-file /root/$i.txt -x reload
  pgloader /root/.newsboat/cache.db postgresql://admin:admin@postgres:5555/rss
end


# Run Newsboat reload in an infinite loop with a sleep interval
while true
    newsboat --log-level 5 --log-file /dev/stdout -x reload
    pgloader /root/.newsboat/cache.db postgresql://admin:admin@postgres:5555/rss
    sleep 300
end

