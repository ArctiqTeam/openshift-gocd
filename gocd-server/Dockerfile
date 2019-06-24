FROM gocd/gocd-server:v19.5.0


# Get Plugins
RUN mkdir -p /go-server/plugins/external/
RUN curl -o /go-server/plugins/external/kubernetes-elastic-agent.jar -s -L https://github.com/gocd/kubernetes-elastic-agents/releases/download/v3.0.0-156/kubernetes-elastic-agent-3.0.0-156.jar 


# Set permissions for OpenShift
RUN chgrp -R 0 /go-server && \
    chmod -R g+rwX /go-server && \
    chmod 664 /etc/passwd 

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]