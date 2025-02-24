#!/bin/bash

export PROCESSOR_NUMBER=15
export DATA_LENGTH=19

print_header() {
    for i in $(seq 0 $PROCESSOR_NUMBER); do
        echo -n cpu $i
        if [ $i -ne $PROCESSOR_NUMBER ]; then
            echo -ne ",\t"
        fi
    done
    echo ""
}

process_line_get() {
    export DATA_TO_ITERATE=$1
    export DATA_POSITION=$(echo "$2 + 3" | bc)
    echo $DATA_TO_ITERATE-$DATA_POSITION
}

print_value() {
    export DATA_TO_ITERATE=$1
    for j in $(seq 0 $PROCESSOR_NUMBER); do
        export DATA_POSITION=$j
        export LINE_TO_PROCESS=$(process_line_get $DATA_TO_ITERATE $DATA_POSITION)
        echo -n $LINE_TO_PROCESS
        if [ $j -ne 15 ]; then
            echo -ne ",\t"
        fi
    done
    echo ""
}

for i in $(seq 0 $DATA_LENGTH); do
    if [ $i -eq 0 ]; then
        print_header
    else  
        print_value $i
    fi
done

