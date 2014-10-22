#!/usr/bin/env python2
import urllib, urllib2, sys
term = urllib.quote_plus(sys.argv[4]) # CBA to find this in urllib2
url = 'https://wiki.somakeit.org.uk/index.php5?search=' + term + '&title=Special%3ASearch'
req = urllib2.Request(url, headers={'User-Agent' : "smib"})
response = urllib2.urlopen(req)
print(response.geturl())
