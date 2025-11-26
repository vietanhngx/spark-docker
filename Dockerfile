FROM python:3.10-bullseye as spark-base

# 1. Cài đặt các công cụ cần thiết và OpenJDK 17
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      curl \
      vim \
      unzip \
      rsync \
      openjdk-17-jdk \
      build-essential \
      software-properties-common \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 2. Thiết lập biến môi trường
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}
RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}
WORKDIR ${SPARK_HOME}

# 3. Chọn phiên bản Spark 3.5.7
ENV SPARK_VERSION=3.5.7

# 4. Tải Spark từ nguồn Apache
RUN curl https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -o spark.tgz && \
    tar xvzf spark.tgz --directory /opt/spark --strip-components 1 && \
    rm -rf spark.tgz

# 5. Cài đặt thư viện Python
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# 6. Cấu hình biến môi trường Spark
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

# Quan trọng: Chỉ định đường dẫn Java 17
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# 7. Copy cấu hình và script khởi chạy
COPY conf/spark-defaults.conf "$SPARK_HOME/conf"
COPY entrypoint.sh .

# Cấp quyền thực thi
RUN chmod +x /opt/spark/entrypoint.sh && \
    chmod +x /opt/spark/sbin/* && \
    chmod +x /opt/spark/bin/*

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

ENTRYPOINT ["./entrypoint.sh"]