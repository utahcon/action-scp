FROM archlinux:latest

# Copy in the entrypoint
COPY entrypoint.sh entrypoint.sh

# Mark our enrtypoint
ENTRYPOINT ["/entrypoint.sh"]