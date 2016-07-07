#!/usr/bin/env python

import scrollphat
import sys
import time
import subprocess

scrollphat.set_brightness(20)
spacer = "    "

while True:
    try:
        temp = subprocess.check_output(["vcgencmd", "measure_temp"]).split("=", 1)[1];
        scrollphat.clear()
        scrollphat.write_string(spacer + temp + spacer);
        for x in range(0, 40):
            scrollphat.scroll()
            time.sleep(0.1)
    except KeyboardInterrupt:
        scrollphat.clear()
        sys.exit(-1)
