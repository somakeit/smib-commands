#!/bin/bash
# set resolution here
# 22=720p, 18=360p, 36=240p, 17=144p, 43=360p(webm)
video_res=17
useragent='User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:32.0) Gecko/20100101 Firefox/32.0'


curl -s -L -A "$useragent" "http://www.youtube.com/get_video_info?video_id=$4" > get_video_info
title=`cat get_video_info | sed 's/%26/&/g'| tr '&' '\n' | grep title= | cut -c 7- | python urldecode.py |sed 's/ //g'|sed 's/\///g'|sed 's/"//g'`
cat get_video_info | sed 's/%26/&/g'| tr '&' '\n' | grep url_encoded_fmt_stream_map | python urldecode.py |  sed 's/url\=/\&/g' | tr '&' '\n' | python urldecode.py | grep http > /tmp/urls.tmp
cat /tmp/urls.tmp | grep itag=$video_res > urls.txt
cat /tmp/urls.tmp | grep -v itag=$video_res >> urls.txt
line=$(head -n 1 urls.txt)

omxplayer $line