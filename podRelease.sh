#!/bin/bash
#chmod +x ./podRelease.sh

podspecName=`find *.podspec -maxdepth 0`

#read -n 1 -p "是否本地校验(1: 是，其他: 否): " isNativeVertify
#
#if [ ${isNativeVertify} = 1 ]; then
#echo -e "\n"
#
##本地校验
#pod lib lint ${podspecName} --sources='http://code.paic.com.cn/iosgitmirror/specs.git,http://code.paic.com.cn/pasmartcity/pasmartspecs.git' --verbose --allow-warnings --use-libraries --no-clean
#


#发布
pod trunk push ${podspecName} --use-libraries --verbose

pod repo update master
