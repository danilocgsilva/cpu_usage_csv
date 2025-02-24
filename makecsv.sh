#!/bin/bash

read -p "Enter the number of processors: " CPU_COUNT
read -p "Write the file name where it was written tne mpstat ouput: " MPSTAT_OUTPUT

export DATA_SIZE=$(echo $CPU_COUNT + 3 | bc)
export DATA_EXCESS=$(echo "$DATA_SIZE + 1" | bc)
DATA_MEASUREMENTS=$(echo $(echo $(wc $MPSTAT_OUTPUT -l | awk '{print $1}') - $DATA_EXCESS | bc ) / $DATA_SIZE | bc)
echo "--> $DATA_MEASUREMENTS - $DATA_EXCESS - $DATA_SIZE"

get_line_to_print() {
    export PROCESSOR_NUMBER=$1
    export DATA_POSITION=$(echo "$2 - 1" | bc)
    export LINE_TO_GET_DATA=$(echo "3 + ($DATA_SIZE * $DATA_POSITION) + $PROCESSOR_NUMBER" + 2 | bc)
    echo -ne "$LINE_TO_GET_DATA"
}

get_data() {
    export LINE_TO_GET_DATA=$1
    export DATA=$(cat $MPSTAT_OUTPUT | head -n $LINE_TO_GET_DATA | tail -n 1 | awk '{print $3}')
    echo -n $DATA
}

print_line() {
    export CPU_COUNT=$1
    echo -ne "cpu$1;\t"
    for i in $(seq $(echo $DATA_MEASUREMENTS | bc)); do
        export LINE_TO_GET_DATA=$(get_line_to_print $1 $i)
        # echo -n $LINE_TO_GET_DATA
        get_data $LINE_TO_GET_DATA
        if [ $i -ne $(echo $DATA_MEASUREMENTS | bc) ]; then
            echo -ne ";\t"
        fi
    done
    echo ""
}

for i in $(seq 0 $(echo $CPU_COUNT - 1 | bc)); do
    print_line $i
done
