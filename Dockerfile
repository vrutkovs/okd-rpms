FROM registry.ci.openshift.org/origin/4.11:artifacts as artifacts
FROM quay.io/openshift/origin-machine-config-operator:4.11 as mcd

FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /rpms
RUN curl -o crio.rpm -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/1.24/Fedora_36/x86_64/cri-o-1.24.1-2.1.fc36.x86_64.rpm && \
    curl -o cri-tools.rpm -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Fedora_36/x86_64/cri-tools-1.24.0-.fc36.1.1.x86_64.rpm
COPY --from=artifacts /srv/repo/*.rpm /rpms/
COPY --from=mcd /usr/bin/machine-config-daemon /binaries/machine-config-daemon
