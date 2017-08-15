#!/bin/bash

ALLPORT=`ps -eo args|grep memcached|grep -v grep|egrep -o '\-p\s*[0-9]+'|awk '{print $2}'`
