#!/bin/bash

OK=0
ERROR=2

if nc -z -w 2 localhost 25; then
    exit "$OK"
else
    exit "$ERROR"
fi