# LAMP Stack in Docker
###### PHP5 + PHP7 + Apache2 + MariaDB in Docker
This docker setup has been tested with Magento 2, WordPress and Symfony 2 -> Symfony 4

## How to set up:
1. Install `docker` and `docker compose` properly
2. Clone project and `cd` into the that
3. Create .env file
```
echo "UID=$UID" > .env
```
4. Create and run container:
```
docker compose up -d
```

## PHP web application:
- Write your code at public_html directory
- Browse to URL: `localhost/info.php` to check if it's running properly
- Your MariaDB database credentials: `root:1@localhost:3306` or `root:1@mariadb:3306`

### Default VirtualHost
- Default PHP version(s): latest PHP 8.x
- Assume your `index.php` is located at `./public_html/projectname/public/index.php`,
please browse to: 
  - `http://public.project.php73` to run your application with PHP 7.3,
  - `http://public.project.php74` (PHP 7.4)
- Tip:
  - You can use dnsmasq instead of /etc/hosts, example:
```
# Redirect all sites in 4 domains (phpXX) to 127.0.0.1
address=/php71/php72/php73/php74/127.0.0.1
```

### Custom VirtualHost
- Add your VirtualHost config files to `./httpd/conf/vhosts/`
- Restart Apache container: `docker restart httpd`

## Use PHP CLI:
- Run command
```shell script
docker compose exec php73 /bin/bash
``` 
or
```shell script
docker compose exec php{xx} /bin/bash
```
- Run you PHP application with command `php ...`
- To debug PHP CLI application: replace `php` by `xdebug`
  - Example: `php bin/console` to `xdebug bin/console`

### Enable/Disable PHP xdebug:
- After ```docker compose exec...``` into container, run
```shell script
toggle-php-mod xdebug
```
or shortcut
```shell script
toggle-php-mod xd
```

### Enable/Disable PHP Opcache:
- After ```docker compose exec...``` into container, run
```shell script
toggle-php-mod opcache
```
or shortcut
```shell script
toggle-php-mod op
```
