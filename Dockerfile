FROM fatherlinux/centos4-base

COPY build-files/start.sh /start.sh

CMD ["/start.sh"]

# Expose port
EXPOSE 22
