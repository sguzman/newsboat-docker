#!/usr/bin/fish

# Run Newsboat reload in an infinite loop with a sleep interval
while true
    newsboat --log-level 5 --log-file /dev/stdout -x reload
    pgloader /root/.newsboat/cache.db postgresql://admin:admin@postgres:5555/rss
    sleep 300
end
