#!/bin/bash
echo "scale=2; `curl -sw "%{speed_download}" http://speedtest.wdc01.softlayer.com/downloads/test10.zip -o test.zip` / 131072" | bc | xargs -I {} echo {}Mb\/s 2>/dev/null
