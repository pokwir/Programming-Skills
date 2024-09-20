#!/bin/bash

seturl(){
    read -p "Enter the URL of the stream: " URL
    read -p "Enter the filename of the stream (without extension): " FILENAME
    read -p "Enter the start time for recording (HH:MM:SS): " START_TIME
    read -p "How long do you want to record for (Mins): " RECORD_TIME 
    echo "Stream URL: $URL"
    echo "Saving audio as: $FILENAME.mp3"
    echo "Recording will start at: $START_TIME"
    echo "Recording will last: $RECORD_TIME Minutes"
}

wait_until_start_time(){
    current_time=$(date +%T)  # Get the current time in HH:MM:SS format

    while [[ "$current_time" != "$START_TIME" ]]
    do
        echo "Waiting for the start time... Current time is $current_time"
        sleep 1  # Check the time every second
        current_time=$(date +%T)  # Update the current time
    done

    echo "Start time reached: $START_TIME. Starting recording..."
}

check_day_of_week_TOD(){
    day_of_week=$(date +%w)   # Day of the week (0-6, 0 is Sunday)

    if [[ $day_of_week -ge 1 && $day_of_week -le 5 ]];  # Monday to Friday
    then
        curl "$URL" > "$FILENAME.mp3"
        echo "Recording started."
    fi
}

main(){
    seturl

    SECONDS=0   # Start the timer
    max_time=$(($RECORD_TIME * 60))  # 125 minutes in seconds

    wait_until_start_time  # Wait until the user-specified start time

    while [[ $SECONDS -lt $max_time ]]
    do
        check_day_of_week_TOD
        sleep 1  # Add a sleep interval to avoid high CPU usage
    done

    echo "Script has run for $RECORD_TIME minutes. Exiting."
    echo "Your file is saved as $FILENAME.mp3"
}

main  # Call the main function
