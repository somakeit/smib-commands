#!/usr/bin/python
import urllib2
import xml.etree.ElementTree as ET

def GetForecastXML(locationCode):
    url = 'http://open.live.bbc.co.uk/weather/feeds/en/{0}/3dayforecast.rss'\
    .format(locationCode)

    page =  urllib2.urlopen(url)
    contents = page.read()

    return contents

def ExtractData(forecastXML):
    tree = ET.fromstring(forecastXML)
    resultString = tree.find('channel').find('title').text

    for day in tree.find('channel').findall('item'):
        resultString += '\n' + day.find('title').text.replace(u'\xb0','')

    return resultString

def main():
    location = 'SO15'
    xmlData = GetForecastXML(location)
    print ExtractData(xmlData)


if __name__ == '__main__':
    main()
