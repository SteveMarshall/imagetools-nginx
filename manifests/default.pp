include apt
include apt::update

apt::source { 'nginx':
  location   => "http://nginx.org/packages/ubuntu",
  repos      => 'nginx',
  key        => '7BD9BF62',
  key_source => 'http://nginx.org/keys/nginx_signing.key',
}

# HACK: Call build-dep manually because apt::builddep creates dependency loop
#       https://gist.github.com/SteveMarshall/11343037
exec { 'apt-builddep-nginx':
  command   => "/usr/bin/apt-get -y --force-yes build-dep nginx",
  logoutput => 'on_failure',
  require   => Apt::Source['nginx'],
}

package { 'libmagickwand-dev':
  require => Exec['apt_update']
}
