#!/usr/bin/env bash

SIZES="128 256 512 1024 2048 4096 8192 16384 16384 32768 65536"
PROFILES="audible audible-7k-channel-0 audible-7k-channel-1 cable-64k ultrasonic ultrasonic-3600 ultrasonic-whisper"

for S in $SIZES; do
    echo "Size: $S"
    dd if=/dev/random of=$S.bin bs=1 count=$S
    
    for P in $PROFILES; do
        quiet_encode_file "$P" $S.bin
        mv encoded.wav "${P}_${S}.wav"
    done
    ls -la *_${S}.wav
done

echo "Done."