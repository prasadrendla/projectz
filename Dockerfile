FROM ubuntu:latest
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y
RUN apt install wget zip tzdata -y
RUN apt install mariadb-server php apache2 php-mysqlnd -y
RUN wget https://wordpress.org/latest.zip
RUN rm -rf /var/www/html/*
RUN unzip latest.zip -d /var/www/html
RUN mv /var/www/html/wordpress/* /var/www/html
RUN mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
RUN sed -i 's/database_name_here/mydb/g' /var/www/html/wp-config.php
RUN sed -i 's/username_here/user1/g' /var/www/html/wp-config.php
RUN sed -i 's/password_here/12345/g' /var/www/html/wp-config.php
RUN sed -i 's/localhost/aws.rds/g' /var/www/html/wp-config.php
EXPOSE 3306
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
