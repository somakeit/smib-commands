#!/usr/bin/python
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
    resultString = tree.find('channel').find('title').text

    for day in tree.find('channel').findall('item'):
        resultString += '\n' + 'Observed at ' + day.find('pubDate').text
        for line in day.find('description').text.split(', '):
            resultString += '\n' + line

    return resultString

def main():
    location = 'SO15'
    xmlData = GetForecastXML(location)
    print ExtractData(xmlData)


if __name__ == '__main__':
    main()
