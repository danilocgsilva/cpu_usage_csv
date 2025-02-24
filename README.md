# CPU Usage CSV

This project is designed to log CPU usage data into CSV files.
It is based on the `mpstat` utility.

## How to use

1. Generate the tracking file. For example, execute the following:
```
mpstat -P ALL 1 15 > data.log
```
This will create a file called `data.log` where data will be recorded.

2. Execute `makecsv.sh`, answering the questions.
