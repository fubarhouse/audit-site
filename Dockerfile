# Base from govcms8lagoon
FROM govcms8lagoon/php

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

# Setup audit-site
RUN mkdir /drutiny
COPY . /drutiny
WORKDIR /drutiny
RUN /app/composer.phar install

# Install Drush
RUN /app/composer.phar require drush/drush:^8

# Add composer bin to environment.
ENV PATH=$PATH:/drutiny/vendor/bin

# Command when none provided.
CMD "/drutiny/vendor/bin/drutiny"