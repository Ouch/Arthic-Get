#!/bin/sh

# Ask the user what they're searching for

echo 'What song would you like to download today?'

# Store the raw track ID to be parsed as a variable
read rawTrackID

## Every spotify track is a randomly generated UUIDv4, but always 73 char in length, char 21 through 53 are the raw ID
## We just need to discard the excess data spotify supplies in order to use freyr to clean up the trackID
function getTrackID {
    #Repeats the spotify link to confirm, then parses up to the 53rd character, dropping and discarding the rest.
echo $rawTrackID | awk '{ printf substr( $rawTrackID, 0, 53 )}' 
}

# Gets called as a function to invoke, when that data's asked.
freyr urify $(getTrackID) --no-logo --no-header

trackID=$(getTrackID)


# Repeats the parsed data for confirmation
echo $trackID

# Downloads song using Freyr
freyr get $trackID --no-logo --no-header