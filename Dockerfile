# Version: 0.0.5 Weblogic 10.3.6 Install
FROM unbc/oraclelinux6
MAINTAINER Trevor Fuson "trevor.fuson@unbc.ca"

# Java Download location. Note the build number is in the URL.
# http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
ENV JAVA_MINOR_VERSION 71
ENV JAVA_BUILD_NUMBER  14
ENV JAVA_HOME          /usr/java/jdk1.7.0_$JAVA_MINOR_VERSION
ENV PATH               $JAVA_HOME/bin:$PATH

# Install Java JDK without leaving behind temporary files
RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
 http://download.oracle.com/otn-pub/java/jdk/7u$JAVA_MINOR_VERSION-b$JAVA_BUILD_NUMBER/jdk-7u$JAVA_MINOR_VERSION-linux-x64.rpm > jdk-7u$JAVA_MINOR_VERSION-linux-x64.rpm && \
 rpm -ivh jdk-7u$JAVA_MINOR_VERSION-linux-x64.rpm && \
 rm jdk-7u$JAVA_MINOR_VERSION-linux-x64.rpm
 
ADD silent.xml          /u01/app/oracle/

RUN curl http://web.unbc.ca/~fuson/docker/wls1036_generic.jar > /u01/app/oracle/wls1036_generic.jar;\
    downloaded_weblogic_sha1sum=$(sha1sum /u01/app/oracle/wls1036_generic.jar);\
    expected_weblogic_sha1sum="ffbc529d598ee4bcd1e8104191c22f1c237b4a3e  /u01/app/oracle/wls1036_generic.jar";\
    if [ "$expected_weblogic_sha1sum" == "$downloaded_weblogic_sha1sum" ];\
       then \
         echo "Checksum Passed, okay to install"       1>&2;\
         echo "Expected: $expected_weblogic_sha1sum"   1>&2;\
         echo "Download: $downloaded_weblogic_sha1sum" 1>&2;\
         java -Dspace.detection=false -Xmx1024m -jar /u01/app/oracle/wls1036_generic.jar -mode=silent -silent_xml=/u01/app/oracle/silent.xml;\
       else \
         echo "Expected: $expected_weblogic_sha1sum"   1>&2;\
         echo "Download: $downloaded_weblogic_sha1sum" 1>&2;\
         echo "Checksum Failed"                        1>&2;\
         exit 1 ;\
    fi;\
    rm u01/app/oracle/wls1036_generic.jar
    