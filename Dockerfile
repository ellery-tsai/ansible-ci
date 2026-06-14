FROM python:3.12-slim

ARG SONAR_SCANNER_VERSION=6.2.1.4610
ENV DEBIAN_FRONTEND=noninteractive
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        openssh-client \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir ansible-lint yamllint

RUN curl -fsSL -o /tmp/sonar-scanner.zip \
    "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux-x64.zip" \
    && unzip /tmp/sonar-scanner.zip -d /opt \
    && mv "/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux-x64" "${SONAR_SCANNER_HOME}" \
    && rm /tmp/sonar-scanner.zip

WORKDIR /work

CMD ["bash"]
