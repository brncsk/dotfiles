#!/usr/bin/python
# wunderpy by Erik Thiem
# wunderpy uses Weather Underground data to easily display the temperature
# Eventually (meaning once I figure out how to do it) wunderpy will be 
# only on the panel. until then, it is a console application

import urllib2 # to download the xml file
import sys # in order to exit
import time # in order to wait for a certain amount of time between xml fetches and to display the time
import os # in order to clear the screen  
from BeautifulSoup import BeautifulSoup
import textwrap # to prettify the weather forecast output

def formatlocation(city, state):
    global currenturl
    global forecasturl

    city_split = city.split(' ') # in case the user's city has a space in it (i.e. multiple word name)
    city_new = '' # so that city can be added to from different parts of city_split
    city_new_forecast = '' #because the download from the forecast needs a '%20' for every space

    for i in range(len(city_split)): # adds the different parts of user_city_split into one string: user_city
        if i == 0:  #it is different when i == 0 so that there is not an initial underscore
            city_new += city_split[i]
        else:
            city_new = city_new + '_' + city_split[i]

    for i in range(len(city_split)): #TODO: REDO THIS USING THE JOIN PROPERTY OF LISTS. IT WILL BE A LOT SIMPLER AND A LOT MORE READABLE
        if i == 0:
            city_new_forecast += city_split[i]
        else:
            city_new_forecast = city_new_forecast + '%20' + city_split[i]

    currenturl = "http://rss.wunderground.com/auto/rss_full/%s/%s.xml?units=english" % (state, city_new)
    forecasturl = "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=%s,%s" % (city_new_forecast, state)


def downloadxml(currenturl, forecasturl):
    global currentxml
    global forecastxml
    opener = urllib2.build_opener()
    try: #the try-except is to handle states that are mistyped with spaces in them. this prevents an ugly message
        currentxml = opener.open(currenturl) # downloads the xml page for the current weather
        forecastxml = opener.open(forecasturl) # downloads the xml page for the weather forecast
    except urllib2.HTTPError:
        os.system('clear')
        print 'wunderpy error # 482'
        print 'If your state name has a space, please enter the abbreviation instead'
        print 'This error is being looked in to'
        sys.exit(1)
    

def currentweather(currentxml): #xmlfile can be any weather underground xml file of format from downloadxml() function
    global currentconditions
    currentconditions = ''
    for line in currentxml:
        if "Current Conditions" in line:
            currentconditions = line
            break
    
    currentconditions = currentconditions[7:-31] # removes <title> tag at beginning and </title> tag at end. also removes time and date

def forecast(xmlfile): 
    global forecastlist
    forecastlist = []
    soup = BeautifulSoup(xmlfile)

    try:
        forecastlist.append(soup.forecast.txt_forecast.findAll('forecastday')[0].fcttext.string) #today's forecast
    except IndexError: #meaning that the xml file did not download correctly, meaning incorrect city
        os.system('clear')
        print 'Error. Invalid city and/or state.'
        print 'You entered "%s, %s"' % (user_city, user_state)
        print 'Maybe you misspelled the city or state. Please try again'
        sys.exit(1)

    forecastlist.append(soup.forecast.txt_forecast.findAll('forecastday')[1].fcttext.string) #tonight's forecast
    

def repeatedloop(currenturl, forecasturl):
    downloadxml(currenturl, forecasturl)
    currentweather(currentxml)
    forecast(forecastxml)

if __name__ == "__main__":
    global user_city
    global user_state

    os.system('clear')
    user_city = raw_input('Please enter the city (spaces are allowed): ')
    user_state = raw_input('Please enter the state (name or abbreviation): ')
    formatlocation(user_city, user_state)
    
    while True:
        try:
            os.system('clear')
            
            if len(user_state) > 2: #if the user has entered in the whole state rather than the abbreviation, capitalize only the first letter
                print 'Location: %s, %s' % (user_city.title(),user_state.title()) #.title() capitalizes 1st letter of every word
            else: #the user has entered in only the state abbrevation
                print 'Location: %s, %s' % (user_city.title(),user_state.upper())
            
            print 'As of:', time.asctime(), '(weather will auto-update every 5 minutes)\n'
            repeatedloop(currenturl, forecasturl) # downloads the two xml files (based on the urls) and parses them, returning current condition and forecast
            dashes = len(currentconditions)+4 #so that the --- line up with the weather
            
            print '\t','-'*dashes # all the --- provides a nice separated area with the actual data
            print '\t|',currentconditions,'|'
            print '\t','-'*dashes,'\n'

            #This block prints out the forecast using info from forecastlist
            print "Forecast:\n"

            print "Today:"
            wrap_today = textwrap.wrap(forecastlist[0], 60) # so that words do not get cut off mid-word --- a word wrap
            for line in wrap_today:
                    print '|',line

            print "\nTomorrow:"
            wrap_tomorrow = textwrap.wrap(forecastlist[1], 60) # so that words do not get cut off mid-word --- a word wrap
            for line in wrap_tomorrow:
                    print '|',line

            print '\n\t\t---(Press Control-c to quit)---'
            time.sleep(300) #pause for 300 seconds (5 minutes) and then fetch and display the weather again
        
        except KeyboardInterrupt:
            os.system('clear')
            print '\nGood Bye. Thank you for using wunderpy.'
            sys.exit(0)
