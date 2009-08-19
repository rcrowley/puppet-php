define php_install($version) {

	package { "libxml2-dev": ensure => latest }
	package { "libexpat1-dev": ensure => latest }
	package { "libssl-dev": ensure => latest }
	package { "libcurl4-openssl-dev": ensure => latest }
	package { "libicu-dev": ensure => latest }
	package { "libmysqlclient15-dev": ensure => latest }
	package { "sendmail": ensure => latest }

	file { "/opt/php-$version.tar.bz2":
		before => Exec["extract-php-$version"],
		source => "puppet://$servername/php/php-$version.tar.bz2",
		ensure => present,
	}
	exec { "extract-php-$version":
		require => File["/opt/php-$version.tar.bz2"],
		before => Exec["configure-php-$version"],
		cwd => "/root",
		command => "tar xjf /opt/php-$version.tar.bz2",
		creates => "/root/php-$version",
		unless => "test -d /opt/php-$version",
	}

	exec { "configure-php-$version":
		require => Exec["extract-php-$version"],
		before => Exec["make-php-$version"],
		cwd => "/root/php-$version",
		command => "./configure --prefix=/opt/php-5.3.0 --enable-cli --enable-cgi --with-openssl --with-curl --with-zlib --enable-intl --with-mysql=mysqlnd --with-mysqli=mysqlnd --enable-pdo --with-pdo-mysql --enable-pcntl --enable-sqlite-utf8 --disable-phar --with-libxml-dir=/usr --with-pear",
		timeout => "-1",
		creates => "/root/php-$version/Makefile",
		onlyif => "test -d /root/php-$version",
	}
	exec { "make-php-$version":
		require => Exec["configure-php-$version"],
		before => Exec["install-php-$version"],
		cwd => "/root/php-$version",
		command => "make",
		timeout => "-1",
		creates => "/root/php-$version/sapi/cli/php",
		onlyif => "test -d /root/php-$version",
	}
	exec { "install-php-$version":
		require => Exec["make-php-$version"],
		before => Exec["remove-php-$version"],
		cwd => "/root/php-$version",
		command => "make install",
		creates => "/opt/php-$version",
		onlyif => "test -d /root/php-$version",
	}

	exec { "remove-php-$version":
		cwd => "/root",
		command => "rm -rf php-$version",
		onlyif => "test -d /root/php-$version",
	}

}

class php {
	include php::php_5_3_0
}
class php::php_5_3_0 {
	php_install { "php-5.3.0": version => "5.3.0" }
}
#class php::php_5_2_8 {
#	php_install { "php-5.2.8": version => "5.2.8" }
#}
