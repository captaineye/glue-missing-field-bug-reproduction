"""
This script is a Glue job that reads data from a MongoDB collection and prints the schema of the data.
"""

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ["JOB_NAME"])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

connectionName = "<your-connection-name>"
db = "<your-db-name>"
collection = "<your-collection-name>"

print(f"Getting data from MongoDB: {db}.{collection}")

frame = glueContext.create_dynamic_frame.from_options(
    connection_type="mongodb",
    connection_options={
        "partitionerOptions.partitionKey": "_id",
        "partitioner": "com.mongodb.spark.sql.connector.read.partitioner.SinglePartitionPartitioner",
        "disableUpdateUri": "false",
        "database": db,
        "partitionerOptions.partitionSizeMB": "10",
        "collection": collection,
        "connectionName": connectionName,
    },
    transformation_ctx=f"{collection}_frame",
)

frame.printSchema()

job.commit()
