FROM postgres
COPY scripts/* /docker-entrypoint-initdb.d/
COPY sql/* /sql/
COPY gcsfuse.repo /etc/yum.repos.d/
RUN dnf -y install gcsfuse
RUN mkdir -p /var/lib/postgresql/data



    
