
# spark-on-oar

Spark-on-oar dynamically provisions an Apache Spark cluster with its standalone resource manager, runs spark jobs, and then deprovisions the cluster on nodes assigned by the OAR hirearchical resource scheduler. 

## Features

* Run under OAR resource limit, i.e. number of nodes, number of cores, memory and walltime
* Multiple spark jobs (master port is selected randomly for each job) for any user
* Only master and workers of the same job are allowed to connect together by a shared secret.

## Requirements

* Linux (should work with most distributions)
* Apache Spark 1.3.0+

## Installation

```bash
# Download Spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz
# Extract the tarball
tar -xvf spark-2.0.1-bin-hadoop2.7.tgz
# Move to desired path ($SPARK_HOME)
mv spark-2.0.1-bin-hadoop2.7 spark

# Clone this repo 
git clone https://github.com/krledmno1/spark-on-oar.git
# copy the bin files
cp spark-on-oar/oar/spark-sbin/* $SPARK_HOME/sbin
```

The assumption is that these files are on a distributed file system (e.g., NFS) and accesible on every node of the cluster.

## Usage

```bash
# create a job folder
mkdir jobs
# copy an example submission script
cp spark-on-oar/oar/spark-multi.sh jobs/
# Edit the $SPARK_HOME env variable in spark-multi.sh to point to your spark folder
# then submit with oarsub, e.g.:
oarsub -l nodes=2/cpu=1/core=1,walltime=0:20 -n sparkPi spark-multi.sh
```
By default spark-multi.sh submits a SparkPi job with parameter 10. You should replace this line with your own submissions.
Spark will write all the logs in your jobs folder.

