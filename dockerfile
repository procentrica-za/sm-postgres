FROM postgres:latest
COPY sql/uuid.sh /docker-entrypoint-initdb.d/
COPY sql/init.sql /docker-entrypoint-initdb.d/




    
