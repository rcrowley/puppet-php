class php {

	package { "libxml2-dev": ensure => latest }
	package { "libexpat1-dev": ensure => latest }
	package { "libssl-dev": ensure => latest }
	package { "libcurl4-openssl-dev": ensure => latest }
	package { "libicu-dev": ensure => latest }
	package { "sendmail": ensure => latest }

	include php::php_5_3_0
	include php::php_5_2_10

}

class php::php_5_3_0 {
	$version = "5.3.0"
	sourceinstall { "php-$version":
		package => "php",
		version => "$version",
		tarball => "puppet://$servername/php/php-$version.tar.bz2",
		flags => "--enable-cli --enable-cgi --with-openssl --with-curl --with-zlib --enable-intl --with-mysql=mysqlnd --with-mysqli=mysqlnd --enable-pdo --with-pdo-mysql --enable-pcntl --enable-sqlite-utf8 --disable-phar --with-libxml-dir=/usr --with-pear",
		bin => "sapi/cli/php",
	}
}

class php::php_5_2_10 {
	package { "libmysqlclient15-dev": ensure => latest }
	$version = "5.2.10"
	sourceinstall { "php-$version":
		package => "php",
		version => "$version",
		tarball => "puppet://$servername/php/php-$version.tar.bz2",
		flags => "--enable-cli --enable-cgi --enable-fastcgi --with-openssl --with-curl --with-zlib  --with-mysql --with-mysqli --enable-pdo --with-pdo-mysql --enable-pcntl --enable-sqlite-utf8 --with-libxml-dir=/usr --with-pear",
		bin => "sapi/cli/php",
	}
}
