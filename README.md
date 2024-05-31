# LAMP Stack in Docker
###### multiple PHP (5.6/7.x/8.x) + Apache2 + MariaDB/Mysql + ... in Docker
This docker setup has been tested with Magento 2, WordPress and Symfony 2 -> Symfony 4

## How to set up:
1. Install `docker` and `docker compose` properly
2. Clone project and `cd` into the that
3. Create configurations files (for the first time):
- `.env`: define docker env variable
- `dclamp.env`: define PHP versions and services
- `docker-compose.yml`: Docker compose file
```shell
./dclamp
```
- Next time, you have to run `./dclamp config` and `./dclamp generate` separately.
4. Create and run container:
```shell
docker compose up -d
```

## PHP web application:
- Write your code at public_html directory
- Browse to URL: `localhost/info.php` to check if it's running properly
- Your MariaDB database credentials: `root:1@localhost:3306` or `root:1@mariadb:3306`

### Default VirtualHost
- Default PHP version(s): latest PHP 8.x
- Assume your `index.php` is located at `./public_html/project-dir/public-dir/index.php`,
please browse to: 
  - `http://public-dir.project-dir73.localhost` to run your application with PHP 7.3,
  - `http://public-dir.project-dir74.localhost` (PHP 7.4)
- You don't have to add entry to `/etc/hosts/` because by default, all .localhost sites will be redirected to 127.0.0.1:
  - If it's not the case, you can use dnsmasq instead of /etc/hosts, example:
```
# Redirect all localhost sites to 127.0.0.1
address=/localhost/127.0.0.1
```

### Custom VirtualHost
- Add your VirtualHost config files to `./httpd/conf/vhosts/`
- Restart Apache container: `docker restart httpd`

## Use PHP CLI:
- Run command
```shell
docker compose exec php73 /bin/bash
``` 
or
```shell
docker compose exec php{xx} /bin/bash
```
- Run you PHP application with command `php ...`
- To debug PHP CLI application: replace `php` by `xdebug`
  - Example: `php bin/console` to `xdebug bin/console`

### Enable/Disable PHP xdebug:
- After ```docker compose exec...``` into container, run
```shell
toggle-php-mod xdebug
```
or shortcut
```shell
toggle-php-mod xd
```

### Enable/Disable PHP Opcache:
- After ```docker compose exec...``` into container, run
```shell
toggle-php-mod opcache
```
or shortcut
```shell
toggle-php-mod op
```
