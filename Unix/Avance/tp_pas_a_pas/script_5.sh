#!/bin/bash

last | sort -n -k 1 | tail -n +2 | head -n -1 | awk '{print $1}' | uniq -c | sort -n -k 1
