#!/usr/bin/env python2

import socket, time
from PIL import Image, ImageFont, ImageDraw
import sys
import fileinput

from FlipdotAPI.FlipdotMatrix import FlipdotMatrix
from FlipdotAPI.FlipdotMatrix import FlipdotImage

WIDTH = 60
HEIGHT = 32

matrix = FlipdotMatrix(
    udpHostsAndPorts = [
        ("flipdot", 2323),
    ],
    imageSize = (WIDTH, HEIGHT),
    transposed = False,
)

while True:
    text = sys.stdin.readline().decode('utf-8')
    if text == "":
        break
    else:
        text = text.strip()
    
    textLength = FlipdotImage.getTextLength(text)
    if textLength > WIDTH:
        scroll = (WIDTH * 2) + textLength + 2
        for y in xrange(0, scroll, 2):
            matrix.showText(text, False, WIDTH - y, 1 )
            matrix.Send()
    else:
        matrix.showText(text, False, 0, 1 )
        matrix.Send()
