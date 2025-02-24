#!/bin/bash

export DATA_SIZE=19
export DATA_MEASUREMENTS=10
export CPU_COUNT=16
export DATA_OFFISET=3

get_line_to_print() {
    export PROCESSOR_NUMBER=$1
    export DATA_POSITION=$(echo "$2 - 1" | bc)
    export LINE_TO_GET_DATA=$(echo "3 + ($DATA_SIZE * $DATA_POSITION)" | bc)
    echo -ne "$LINE_TO_GET_DATA-$DATA_POSITION"
}

print_line() {
    echo -ne "cpu$1,\t"
    for i in $(seq $(echo $DATA_MEASUREMENTS | bc)); do
        get_line_to_print $1 $i
        if [ $i -ne $(echo $DATA_MEASUREMENTS | bc) ]; then
            echo -ne ",\t"
        fi
    done
    echo ""
}

for i in $(seq 0 $(echo $CPU_COUNT - 1 | bc)); do
    print_line $i
done
