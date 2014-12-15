#!/usr/bin/env python2
import urllib2
import xml.etree.ElementTree as ET

def GetForecastXML(locationCode):

    url = 'http://open.live.bbc.co.uk/weather/feeds/en/{0}/observations.rss'\
    .format(locationCode)

    page =  urllib2.urlopen(url)
    contents = page.read()

    return contents

def ExtractData(forecastXML):
    tree = ET.fromstring(forecastXML)
    results = []
    results.append(tree.find('channel').find('title').text)

    for day in tree.find('channel').findall('item'):
        results.append('Observed at ' + day.find('pubDate').text)
        for line in day.find('description').text.split(', '):
            if(results[-1][-2:] == 'mb'):
                results[-1] = results[-1] + ' ' + line.replace(u'\xb0','')
            else:
                results.append(line.replace(u'\xb0',''))

    return '\n'.join(results)

def main():
    location = 'SO15'
    xmlData = GetForecastXML(location)
    print ExtractData(xmlData)


if __name__ == '__main__':
    main()
