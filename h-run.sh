#!/usr/bin/env bash

cd `dirname $0`

install_miner() {
	mkdir beam_opencl
	cd beam_opencl
	wget https://github.com/OctavioMaia/BeamMW_HiveOS/releases/download/v1.1/beam_opencl.tar.gz
        tar -zxf beam_opencl.tar.gz
	rm beam_opencl.tar.gz
} 


[ -t 1 ] && . colors

. h-manifest.conf

[[ -z $CUSTOM_LOG_BASENAME ]] && echo -e "${RED}No CUSTOM_LOG_BASENAME is set${NOCOLOR}" && exit 1
[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && exit 1
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}Custom config ${YELLOW}$CUSTOM_CONFIG_FILENAME${RED} is not found${NOCOLOR}" && exit 1
CUSTOM_LOG_BASEDIR=`dirname "$CUSTOM_LOG_BASENAME"`
[[ ! -d $CUSTOM_LOG_BASEDIR ]] && mkdir -p $CUSTOM_LOG_BASEDIR
[[ ! -d ./beam-opencl.miner ]] && install_miner


./beam-opencl-miner $(< /hive/miners/custom/$CUSTOM_NAME/$CUSTOM_NAME.conf) $@ 2>&1 | tee $CUSTOM_LOG_BASENAME.log