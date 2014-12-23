# Version: 0.0.5 Weblogic 10.3.6 Install
FROM komljen/jdk6-oracle
MAINTAINER Paul d'Hubert

ADD silent.xml          /u01/app/oracle/

RUN curl http://web.unbc.ca/~fuson/docker/wls1036_generic.jar > /u01/app/oracle/wls1036_generic.jar;\
    downloaded_weblogic_sha1sum=$(sha1sum /u01/app/oracle/wls1036_generic.jar);\
    expected_weblogic_sha1sum="ffbc529d598ee4bcd1e8104191c22f1c237b4a3e  /u01/app/oracle/wls1036_generic.jar";\
         echo "Checksum Passed, okay to install"       1>&2;\
         echo "Expected: $expected_weblogic_sha1sum"   1>&2;\
         echo "Download: $downloaded_weblogic_sha1sum" 1>&2;\
         java -Dspace.detection=false -Xmx1024m -jar /u01/app/oracle/wls1036_generic.jar -mode=silent -silent_xml=/u01/app/oracle/silent.xml;\
    rm u01/app/oracle/wls1036_generic.jar
    
