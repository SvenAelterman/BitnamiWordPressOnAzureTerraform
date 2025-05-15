FROM bitnami/wordpress:6.7.2

# Ref: https://learn.microsoft.com/azure/app-service/configure-custom-container?tabs=debian&pivots=container-linux

# Bitnami's image is set to run as USER 1001, but we need to install packages as root
USER root

# Start and enable SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/

HEALTHCHECK NONE

EXPOSE 8080 2222

# Set back to running as USER 1001
USER 1001
