# LAMP Stack in Docker
###### PHP5 + PHP7 + Apache2 + Mariadb in Docker
This docker setup has been tested with Magento 2, Wordpress and Symfony 2 -> Symfony 4

## How to setup:
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
- Your Mariadb/Mysql database credentials: `root:1@10.5.0.6:3306` or `root:1@maziadb:3306`

### Default VirtualHost
- PHP is pre-setup with 3 versions: PHP 5.6, PHP 7.1 and PHP 7.2
- Assume your `index.php` is located at `./public_html/projectname/public/index.php`,
please browse to: 
  - `http://public.project.php56` to run your application with PHP 5.6,
  - `http://public.project.php71` (PHP 7.1)
  - `http://public.project.php72` (PHP 7.2)

### Custom VirtualHost
- Add your VirtualHost config files to `./httpd/conf/vhosts/`
- Restart Apache container: `docker restart httpd`

## Use PHP CLI:
- Run command
```shell script
docker exec -it php71 /bin/bash
``` 
or
```shell script
docker exec -it php{xx} /bin/bash
```
- Run you PHP application with command `php ...`


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
