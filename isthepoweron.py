#!/usr/bin/env/python

import paho.mqtt.client
import json
import time
import sys

def on_connect(client, userdata, flags, rc):
    client.subscribe("somakeit/space/power/usage")

def stop(client):
    client.disconnect()
    client.loop_stop()
    sys.exit()

def on_message(client, userdata, msg):
    message = json.loads(msg.payload)

    if message["timestamp"] < (time.time() - 20):
        print "The energy monitor isn't working. :-/"
        stop(client)

    phase1 = int(message["msg"]["ch1"]["watts"])
    phase2 = int(message["msg"]["ch1"]["watts"])
    phase3 = int(message["msg"]["ch1"]["watts"])
    total = phase1 + phase2 + phase3

    print "Space is using " + str(total) + "W (main room: " + str(phase1) + "W, workshop: " + str(phase3) + "W, lights: " + str(phase2) + "W)"

    stop(client)

mqtt = paho.mqtt.client.Client(client_id="smib", clean_session=True)
mqtt.on_connect = on_connect
mqtt.on_message = on_message
mqtt.tls_set("/etc/ssl/certs/ca-certificates.crt")
mqtt.username_pw_set("smib", "G@1WI2#x1NEt")
mqtt.connect("spacehub.somakeit.org.uk", port=1883)
mqtt.loop_forever(timeout=1.0, max_packets=1, retry_first_connection=False)
