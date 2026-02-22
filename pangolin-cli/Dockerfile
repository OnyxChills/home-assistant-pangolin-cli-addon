# Use the official Home Assistant add-on base image
FROM ghcr.io/hassio-addons/base:20.0.1

# Define the Newt version (used everywhere below)
ARG PANGOLIN_CLI_VERSION=0.3.3
ENV PANGOLIN_CLI_VERSION=${PANGOLIN_CLI_VERSION}

# Detect system architecture and download the correct Newt binary
RUN wget https://static.pangolin.net/get-cli.sh -O /get-cli.sh && \
    chmod +x /get-cli.sh && \
    /get-cli.sh && \
    rm /get-cli.sh
# Copy and prepare run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start the add-on
ENTRYPOINT ["/run.sh"]
