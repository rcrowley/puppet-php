class php {

	package {
		"libxml2-dev": ensure => latest;
		"libexpat1-dev": ensure => latest;
#		"libssl-dev": ensure => latest; # Now in sourceinstall::build
		"libcurl4-openssl-dev": ensure => latest;
		"libicu-dev": ensure => latest;
#		"sendmail": ensure => latest;
	}

	include php::php_5_3_0
	include php::php_5_2_10

	file { "/usr/local/bin/pick-php":
		source => "puppet://$servername/php/pick-php",
		ensure => present,
	}

}

class php::php_5_3_0 {
	$version = "5.3.0"
	sourceinstall { "php-$version":
		tarball => "http://us3.php.net/get/php-$version.tar.bz2/from/this/mirror",
		prefix => "/opt/php-$version",
		flags => "--enable-cli --enable-cgi --with-openssl --with-curl --with-zlib --enable-intl --with-mysql=mysqlnd --with-mysqli=mysqlnd --enable-pdo --with-pdo-mysql --enable-pcntl --enable-sqlite-utf8 --disable-phar --with-libxml-dir=/usr --with-pear",
	}
}

class php::php_5_2_10 {
	package { "libmysqlclient15-dev": ensure => latest }
	$version = "5.2.10"
	sourceinstall { "php-$version":
		tarball => "http://us3.php.net/get/php-$version.tar.bz2/from/this/mirror",
		prefix => "/opt/php-$version",
		flags => "--enable-cli --enable-cgi --enable-fastcgi --with-openssl --with-curl --with-zlib  --with-mysql --with-mysqli --enable-pdo --with-pdo-mysql --enable-pcntl --enable-sqlite-utf8 --with-libxml-dir=/usr --with-pear",
	}
}
