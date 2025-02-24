FROM icr.io/appcafe/websphere-liberty:24.0.0.12-full-java17-openj9-ubi

# Copy some files to the server configuration directory
COPY --chown=1001:0 ./jvm.options /opt/ibm/wlp/usr/servers/defaultServer
COPY --chown=1001:0 ./server.env /opt/ibm/wlp/usr/servers/defaultServer
COPY --chown=1001:0 ./server.xml /opt/ibm/wlp/usr/servers/defaultServer

EXPOSE 9080

CMD /opt/ibm/wlp/bin/server run defaultServer --clean