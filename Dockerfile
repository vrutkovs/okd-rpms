FROM registry.ci.openshift.org/origin/4.10:artifacts as artifacts
FROM quay.io/openshift/origin-machine-config-operator:4.10 as mcd

FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /rpms
RUN curl -o crio.rpm -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/1.23/Fedora_35/x86_64/cri-o-1.23.1-1.1.fc35.x86_64.rpm && \
    curl -o cri-tools.rpm -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Fedora_34/x86_64/cri-tools-1.21.0-.fc34.2.1.x86_64.rpm
COPY --from=artifacts /srv/repo/*.rpm /rpms/
COPY --from=mcd /usr/bin/machine-config-daemon /binaries/machine-config-daemon
