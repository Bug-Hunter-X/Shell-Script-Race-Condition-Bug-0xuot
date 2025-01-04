# Shell Script Race Condition Bug

This repository demonstrates a race condition bug in a bash shell script.  Two processes concurrently write to the same files, resulting in non-deterministic output. The solution introduces file locking to ensure sequential access.

## Bug Description
The `bug.sh` script creates two processes that write to two files concurrently. Due to the asynchronous nature, the order of writes is not guaranteed, leading to unexpected results.