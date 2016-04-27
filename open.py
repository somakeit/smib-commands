#!/usr/bin/env python

import paho.mqtt.client
import sys

def on_connect(client, userdata, flags, rc):
    client.subscribe("somakeit/space/open")

def stop(client):
    client.disconnect()
    client.loop_stop()
    sys.exit()

def on_message(client, userdata, msg):
    if msg.payload == '0':
        print 'The space is closed.'
    elif msg.payload == '1':
        print 'The space is open!'
    else:
        print 'Well, this is embarrasing, the button seems to be broken.. The space is both open and closed until you go and observe it and fix the button.'

    stop(client)

mqtt = paho.mqtt.client.Client(client_id="smib", clean_session=True)
mqtt.on_connect = on_connect
mqtt.on_message = on_message
mqtt.tls_set("/etc/ssl/certs/ca-certificates.crt")
mqtt.username_pw_set("smib", "G@1WI2#x1NEt")
mqtt.connect("spacehub.somakeit.org.uk", port=1883)
mqtt.loop_forever(timeout=1.0, max_packets=1, retry_first_connection=False)
