#!/bin/bash

print_line() {
    for i in $(seq 0 15); do
        echo -n $i
        if [ $i -ne 15 ]; then
            echo -n ","
        fi
    done
    echo ""
}

for i in $(seq 0 19); do
    print_line
done

