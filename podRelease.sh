#!/bin/bash
#chmod +x ./podRelease.sh

podspecName=`find *.podspec -maxdepth 0`


#发布
pod trunk push ${podspecName} --use-libraries --verbose

pod repo update master
