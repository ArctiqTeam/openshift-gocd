FROM gocd/gocd-agent-centos-7:v19.5.0

# Install Ansible
RUN yum install -y epel-release && \
    yum install -y ansible

# Obtain oc client
RUN curl -o oc.tar.gz -s -L  https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz  && \
    tar -xvf oc.tar.gz --strip-components=1 && \
    mv oc /usr/local/bin/oc


# Set permissions for OpenShift
RUN mkdir /go  && \
    chgrp -R 0 /go && \
    chmod -R g+rwX /go && \
    chgrp -R 0 /go-agent && \
    chmod -R g+rwX /go-agent && \
    mkdir /.ansible && \
    chgrp -R 0 /.ansible && \
    chmod -R g+rwX /.ansible && \
    chgrp -R 0 /go-agent && \
    chmod -R g+rwX /go-agent && \
    chmod 664 /etc/passwd 



ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]