# LAMP Stack in Docker
###### PHP5 + PHP7 + Apache2 + MariaDB in Docker
This docker setup has been tested with Magento 2, Wordpress and Symfony 2 -> Symfony 4

## How to set up:
1. Install docker and docker-compose properly
2. Clone project and `cd` into the that
3. Edit UID in `docker-compose.yml` to your current user ID to avoid permissions issues (usually it's 1000).
4. Edit USER_NAME to whatever you want (optional).
5. Create and run container:
```shell script
docker-compose up -d
```

## PHP web application:
- Write your code at public_html directory
- Browse to URL: `localhost/info.php` to check if it's running properly
- Your MariaDB database credentials: `root:1@10.5.0.100:3306` or `root:1@maziadb:3306`

### Default VirtualHost
- PHP is pre-setup with 2 versions: PHP 7.3 and PHP 7.4
- Assume your `index.php` is located at `./public_html/projectname/public/index.php`,
please browse to: 
  - `http://public.project.php73` to run your application with PHP 7.3,
  - `http://public.project.php74` (PHP 7.4)

### Custom VirtualHost
- Add your VirtualHost config files to `./httpd/conf/vhosts/`
- Restart Apache container: `docker restart httpd`

## Use PHP CLI:
- Run command
```shell script
docker exec -it php73 /bin/bash
``` 
or
```shell script
docker exec -it php{xx} /bin/bash
```
- Run you PHP application with command `php ...`
- To debug PHP CLI application: replace `php` by `xdebug`
  - Example: `php bin/console` to `xdebug bin/console`

### Enable/Disable PHP xdebug:
- After ```docker exec...``` into container, run
```shell script
toggle-php-mod xdebug
```
or shortcut
```shell script
toggle-php-mod xd
```

### Enable/Disable PHP Opcache:
- After ```docker exec...``` into container, run
```shell script
toggle-php-mod opcache
```
or shortcut
```shell script
toggle-php-mod op
```
