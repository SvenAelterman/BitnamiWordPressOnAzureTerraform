ARG BITNAMI_VERSION=6.7.2
FROM bitnami/wordpress:${BITNAMI_VERSION}

# Ref: https://learn.microsoft.com/azure/app-service/configure-custom-container?tabs=debian&pivots=container-linux#enable-ssh

# Bitnami's image is set to run as USER 1001, but we need to install packages and run SSH as root
USER root

# Use a custom entrypoint script which will start SSH and then run the original entrypoint script / CMD
COPY entrypoint.sh ./

# Install SSH and perform some configuration
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    # Required for App Service SSH
    && echo "root:Docker!" | chpasswd \ 
    && chmod u+x ./entrypoint.sh

# Copy the SSH configuration file containing the required configuration for App Service SSH
COPY sshd_config /etc/ssh/

# For Trivy check to pass
HEALTHCHECK NONE

# Expose the SSH port (custom port 2222 for App Service SSH) in addition to the HTTP and HTTPS ports
# HTTPS is to support App Service end-to-end TLS (optional configuration)
EXPOSE 8080 8443 2222

ENTRYPOINT [ "./entrypoint.sh" ]
# The original CMD from Bitnami's image
CMD ["/opt/bitnami/scripts/apache/run.sh"]

# Do not revert to running as USER 1001 because App Service SSH requires root
