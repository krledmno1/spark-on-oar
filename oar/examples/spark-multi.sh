#!/bin/bash
#


export SPARK_HOME=$HOME/spark  
export SPARK_JOB_DIR=$HOME/jobs

#????
export SPARK_PREFIX=$HOME/spark

# Create/append spark configuration in SPARK_JOB_DIR from PBS environments. 
# Specific spark configuration can be put into the SPARK_JOB_DIR/conf/* a priori.
# If existing configuration is found SPARK_JOB_DIR/conf/*, spark-on-hpc.sh will
#   append its auto-generated section. 
# If rerun the job, delete the auto-generated section first
$SPARK_HOME/sbin/spark-on-hpc.sh config || { exit 1; }

# Start a spark cluster inside HPC using oar
# First node will be dedicated to the master. The rest nodes are workers. 
$SPARK_HOME/sbin/spark-on-hpc.sh start


#User submissions:

$SPARK_HOME/sbin/spark-submit-on-hpc.sh org.apache.spark.examples.SparkPi $SPARK_HOME/examples/jars/spark-examples_2.11-2.0.1.jar 10
#add more here...


# Stop the spark cluster
$SPARK_HOME/sbin/spark-on-hpc.sh stop

