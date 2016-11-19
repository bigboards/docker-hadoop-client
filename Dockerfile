# Pull base image.
FROM bigboards/base-client-__arch__

MAINTAINER bigboards
USER root

# Install hadoop-client
RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz | tar -xz -C /opt
RUN cd /opt && ln -s ./hadoop-2.6.4 hadoop

ENV HADOOP_PREFIX /opt/hadoop
ENV YARN_HOME /opt/hadoop
ENV HADOOP_YARN_HOME /opt/hadoop
ENV HADOOP_HDFS_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HDFS_CONF_DIR /opt/hadoop/etc/hadoop
ENV YARN_CONF_DIR /opt/hadoop/etc/hadoop

# copy the scripts
ADD hadoop-shell /bin/hadoop-shell
RUN chmod a+x /bin/hadoop-shell

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb