FROM archlinux:latest

# Install SSH tools
RUN yes | pacman -Syu openssh

# Copy in the entrypoint
COPY entrypoint.sh entrypoint.sh

# Mark our enrtypoint
ENTRYPOINT ["/entrypoint.sh"]