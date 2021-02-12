# Measurement Server

Contains the files for hosting server for running MobiPerf-supported TCP speed test and UDP burst test.

Run the server using docker:

```
docker run -p 6001:6001 -p 6002:6002 -p 6003:6003 -p 31341:31341 staveesh/speedserver:latest
```

OR

1. ```
    git clone https://github.com/staveesh/measurement_server.git
   ```
2. ```
    cd measurement_server
   ```   
3. Compile java code
   ```
    /bin/sh compile.sh
   ```
4. Run the server
   ```
    /bin/bash start.sh
   ```
5. Stop the server
    ```
    /bin/bash stop.sh
    ```