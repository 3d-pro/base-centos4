FROM fatherlinux/centos4-base

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 HOME=/root TERM=xterm
RUN sed -ri -e 's/^mirrorlist/#mirrorlist/g' -e 's/#baseurl=http:\/\/mirror\.centos\.org\/centos\/\$releasever/baseurl=http:\/\/vault\.centos\.org\/4\.9/g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum install -y openssh vixie-cron logrotate wget && \
    curl -ko /tmp/bash-3.0-27.0.3.el4.src.rpm https://oss.oracle.com/el4/SRPMS-updates/bash-3.0-27.0.3.el4.src.rpm && \
    curl -ko /tmp/glibc-2.3.4-2.57.0.1.el4.1.src.rpm https://oss.oracle.com/el4/SRPMS-updates/glibc-2.3.4-2.57.0.1.el4.1.src.rpm && \
    curl -ko /tmp/openssl-0.9.7a-43.18.0.2.el4.src.rpm https://oss.oracle.com/el4/SRPMS-updates/openssl-0.9.7a-43.18.0.2.el4.src.rpm && \
    curl -ko /tmp/tzdata-2016b-1.0.1.el4.src.rpm https://oss.oracle.com/el4/SRPMS-updates/tzdata-2016b-1.0.1.el4.src.rpm && \
    yum install -y openssh rsyslog gcc rpm-build bison texinfo libtermcap-devel gd-devel libpng-devel zlib-devel libselinux-devel audit-libs-devel libcap-devel krb5-devel && \
    rpmbuild --rebuild /tmp/bash-3.0-27.0.3.el4.src.rpm && \
    rpmbuild --rebuild /tmp/glibc-2.3.4-2.57.0.1.el4.1.src.rpm && \
    rpmbuild --rebuild /tmp/openssl-0.9.7a-43.18.0.2.el4.src.rpm && \
    rpmbuild --rebuild /tmp/tzdata-2016b-1.0.1.el4.src.rpm && \
    rpm -Uvh /usr/src/redhat/RPMS/x86_64/bash-3.0-27.0.3.x86_64.rpm && \
    rpm -Uvh /usr/src/redhat/RPMS/x86_64/glibc-2.3.4-2.57.0.1.x86_64.rpm && \
    rpm -Uvh /usr/src/redhat/RPMS/x86_64/openssl-0.9.7a-43.18.0.2.x86_64.rpm && \
    rpm -Uvh /usr/src/redhat/RPMS/x86_64/tzdata-2016b-1.0.1.x86_64.rpm && \
    yum remove -y gcc rpm-build bison texinfo libtermcap-devel gd-devel libpng-devel zlib-devel libselinux-devel audit-libs-devel libcap-devel krb5-devel && \
    rm -f /tmp/bash-3.0-27.0.3.el4.src.rpm /tmp/glibc-2.3.4-2.57.0.1.el4.1.src.rpm /tmp/openssl-0.9.7a-43.18.0.2.el4.src.rpm /tmp/tzdata-2016b-1.0.1.el4.src.rpm && \
    yum clean all

COPY build-files/start.sh /start.sh

CMD ["/start.sh"]

# Expose port
EXPOSE 22
