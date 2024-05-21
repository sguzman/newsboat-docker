#!/usr/bin/fish
#
# First load each rss file one at a time

set -x fish_trace 1

for t in tradingecon youtube podcasts govinfo
  echo $t
  cat /root/urls/$t.txt >> /root/.newsboat/urls
  newsboat --log-level 5 --log-file /dev/stdout --url-file "/root/urls/$t.txt" -x reload
  pgloader /root/.newsboat/cache.db postgresql://admin:admin@postgres:5432/rss
end


# Run Newsboat reload in an infinite loop with a sleep interval
while true
    newsboat --log-level 5 --log-file /dev/stdout -x reload
    pgloader /root/.newsboat/cache.db postgresql://admin:admin@postgres:5432/rss
    sleep 300
end

