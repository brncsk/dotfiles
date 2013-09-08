#!/usr/bin/env python3
# coding=UTF-8
from __future__ import print_function
import sys
import dbus

target = None

try:
    bus = dbus.SessionBus()
    dbusObj = bus.get_object('org.freedesktop.DBus', '/')
    for name in dbusObj.ListNames(dbus_interface='org.freedesktop.DBus'):
        if name.startswith('org.mpris.MediaPlayer2.'):
            target = name
            break
except:
    sys.exit(1)

if target is None:
    sys.exit(1)

targetObject = bus.get_object(target, '/org/mpris/MediaPlayer2')
mpris = dbus.Interface(targetObject, dbus_interface='org.mpris.MediaPlayer2.Player')
properties = dbus.Interface(targetObject, dbus_interface='org.freedesktop.DBus.Properties')

playerName = properties.Get('org.mpris.MediaPlayer2', 'Identity')
props = properties.GetAll('org.mpris.MediaPlayer2.Player')
metadata = props['Metadata']

if props['PlaybackStatus'].strip() == 'Playing':
    print('State: PLAY')
elif props['PlaybackStatus'].strip() == 'Paused':
    print('State: PAUSE')


if 'xesam:title' in metadata:
    print('SongTitle:', metadata['xesam:title'].strip())
if 'xesam:artist' in metadata:
    print('Artist:', metadata['xesam:artist'][0].strip())
