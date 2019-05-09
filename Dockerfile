FROM fedora:latest
MAINTAINER joey@binbash.org

# Install Dependencies
RUN dnf install -y dnf-plugins-core
RUN dnf -y copr enable aflyhorse/iozone
RUN dnf install -y bonnie++ sysbench fio hdparm iozone

# Run an infinite tail
CMD ["sh", "-c", "tail -f /dev/null"]
