#!/bin/sh

# Run Newsboat reload in an infinite loop with a sleep interval
while true; do
    newsboat -x reload
    sleep 300
done

