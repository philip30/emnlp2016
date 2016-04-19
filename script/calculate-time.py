#!/usr/bin/env python3

import sys
import os
import datetime

from datetime import timedelta

if len(sys.argv) <= 2:
    raise Exception("Usage calculate-time.py [log] [output_pattern]")

def read_log(fp):
    data = None
    ret = []
    for line in fp:
        line = line.strip().split()

        # reading time
        try : line[1] = line[1][:line[1].index(".")]
        except: continue
        date = datetime.datetime.strptime(line[0] + " " + line[1], "%Y-%m-%d %H:%M:%S")

        # reading type
        if line[-3] == "Starting" and line[-2] == "Epoch":
            if data is not None:
                ret.append(data)
            data = (int(line[-1]), date, [])
        else:
            if data is not None and line[3].startswith("Trained"):
                data[2].append(date)
    ret.append(data)
    return ret

def calculate_epoch_time(epoch):
    date = epoch[1]
    last_date = epoch[2][-1]
    return (last_date - date).seconds/60

# START 
output_pattern = sys.argv[2]

with open(sys.argv[1]) as input_file:
    epoch_data = read_log(input_file)

last_time = 0
for i, data in enumerate(epoch_data):
    last_time += calculate_epoch_time(data)
    
    with open(output_pattern + "/test-%d.time" % i, "w") as ofp:
        print("%.2f" % last_time, file=ofp)
        
