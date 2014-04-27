nginx.deb
=========

Tools to build a custom nginx package that meets our needs.

This involves getting the source for the offical nginx.org Ubuntu
package (using `apt-get source`), applying our patches, and then
rebuilding the package. Our patches will:

- Add the [ngx_small_light module](https://github.com/cubicdaiya/ngx_small_light)
- Add a custom version number, to avoid conflicts

Usage
-----

You want one of the [releases](#TODO). Copy it locally, then install it
with `dpkg -i <filename>`.

Development
-----------

This repo uses [Vagrant 1.5](http://www.vagrantup.com/downloads.html)
(to get the basebox) with [`vagrant-librarian-puppet`
plugin](https://github.com/mhahn/vagrant-librarian-puppet) (which can
be installed by running `vagrant plugin install
vagrant-librarian-puppet`). You will also need to run `bundle install`
to install Puppet for `vagrant-librarian-puppet`, because it uses the
`puppet module` command to download modules listed in the Puppetfile.

Once in the VM, `cd /vagrant` and run `make` to build our custom nginx
module. At the moment, releases are carried out manually.
