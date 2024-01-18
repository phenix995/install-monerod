# Use a Ubuntu base image
FROM ubuntu:noble

# Install Monero from the Debian repository
RUN apt-get update && apt-get install -y monero && rm -rf /var/lib/apt/lists/*

# Create a user for the monero service
RUN useradd --system --no-create-home monero

# Find out the installation path of monerod and adjust the configuration file path if necessary
# Assuming monerod is installed in /usr/bin
COPY monerod.conf /usr/bin/monerod.conf

# Create and set permissions for the Monero data directory
RUN mkdir -p /var/lib/monero && chown -R monero:monero /var/lib/monero

# Set the entrypoint to monerod with the specified configuration
ENTRYPOINT ["/usr/bin/monerod","--non-interactive", "--config-file", "/usr/bin/monerod.conf", "--pidfile", "/var/lib/monero/monerod.pid"]

# Expose necessary ports
EXPOSE 18080 18089

# Set the user
USER monero:monero

# Set volume for the blockchain
VOLUME /var/lib/monero

# Note: The restart policy is handled by Docker's restart policy when running the container
