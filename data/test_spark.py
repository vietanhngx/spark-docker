from pyspark.sql import SparkSession
import random

spark = SparkSession.builder.appName("TestApp").getOrCreate()
print(">>> HELLO SPARK! Phien ban cua ban la: ", spark.version)
spark.stop()