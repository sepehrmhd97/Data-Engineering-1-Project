
# Bitcoin Price and Reddit Comments Analysis Using PySpark

## The Analysis

The relationship between the change in the number of reddit comments related to Bitcoin and the price of Bitcoin is the objective of the analysis.

## The Tools

To perform this analysis, Spark cluster is used. Moreover, for easy contextualization of nodes, Docker is used.

## Contextualize
Before actually contextualize the Spark (and Hadoop) containers, make sure every machines are able to `ssh` to each other by configuring `/etc/hosts`, `~/.ssh/config`, and `~/.ssh/authorized_keys`. Additionally, Docker must be installed.

1. Configure Spark and Hadoop by editing files inside `hadoop-configs` folder.

    - Specify the hostname or IP of spark master in `spark-env.sh` script.
    - Put the hostnames or IPs of workers in `workers` file.

2. Clone this repository then `cd` into it and get in super user mode.

    ```bash
    $ git clone https://github.com/sepehrmhd97/Data-Engineering-1-Project.git
    $ cd Data-Engineering-1-Project
    $ sudo bash
    ```

3. Build the image.

    ```bash
    $ ./build.sh
    ```
    
4. Run the master at one VM.

    Use the `-f` flag to format the namenode.

    ```bash
    $ ./start-master.sh [-f]
    ```

5. Run the workers on multiple VMs.

    The `-h` flag must be provided. The value is the worker's hostname that's also present in `/etc/hosts` and `workers` files.

    ```bash
    $ ./start-worker.sh -h [workers_hostname]
    ```

6. The cluster should be up and running.
    
    The Spark UI and HDFS GUI should be runnin on master on port `8080` and `9870` respectively