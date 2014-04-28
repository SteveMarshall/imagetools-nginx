# Tizaro-nginx

Tools to build a custom nginx package that meets Tizaro's needs.

The output of this tool has these differences to the [stable nginx.org
package](http://nginx.org/en/linux_packages.html#stable):

- [ngx_http_image_filter](http://nginx.org/en/docs/http/ngx_http_image_filter_module.html) support
- [ngx_small_light](https://github.com/cubicdaiya/ngx_small_light) support

## Installing Tizaro's custom nginx

Copy an appropriate [release](#TODO) locally, and install it
with `dpkg -i <filename>`.

## Usage

Prerequisites:

- [Vagrant 1.5](http://www.vagrantup.com/downloads.html) (for basebox
  autoloading)
- [`vagrant-librarian-puppet`](https://github.com/mhahn/vagrant-librarian-puppet)
  (which can be installed by running `vagrant plugin install vagrant-librarian-puppet`,
  and requires Puppet, which can be installed with `bundle install`)

To build the nginx package:

```bash
vagrant up                             # Create the VM
vagrant ssh -c "cd /vagrant && make"   # Log in to the VM and build the package
```

After this is complete, the `build` directory will contain two nginx
`.deb` files, one with debug enabled and one without (indicated in the
name). We release/deploy the latter of the two, currently by manually
creating a GitHub release.
