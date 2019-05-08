FROM fedora:latest
MAINTAINER joey@binbash.org

# Install Dependencies
RUN dnf install -y bonnie++

# Run an infinite tail
CMD ["sh", "-c", "tail -f /dev/null"]
