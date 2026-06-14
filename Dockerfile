FROM registry.access.redhat.com/ubi9/python-312

USER root

ARG SONAR_SCANNER_VERSION=6.2.1.4610
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

RUN dnf install -y --nodocs \
        ca-certificates \
        curl \
        git \
        openssh-clients \
        unzip \
    && dnf clean all

RUN pip install --no-cache-dir ansible-lint yamllint

RUN curl -fsSL -o /tmp/sonar-scanner.zip \
    "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux-x64.zip" \
    && unzip /tmp/sonar-scanner.zip -d /opt \
    && mv "/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux-x64" "${SONAR_SCANNER_HOME}" \
    && rm /tmp/sonar-scanner.zip

WORKDIR /work

CMD ["bash"]
