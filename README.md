# hello-world-cookbook
[![Build Status](https://travis-ci.org/willejs/chef-hello-world.svg?branch=master)](https://travis-ci.org/willejs/chef-hello-world)
This cookbook runs the simple [go-hello-world](http://github.com/willejs/go-hello-world)

This cookbook makes some assumptions that using community cookbooks is mostly good, and sticking to stable, supported OS's is better than shiny things.
Assumptions:
- Ubuntu 14.04 LTS is the primarily supported OS
- Upstart for process supervision - I would prefer to run runit for [various reasons](http://jtimberman.housepub.org/blog/2012/12/29/process-supervision-solved-problem/), but upstart is the standard in 14.04. I would prefer to run systemd if I was not running > 14.04.
- The golang community chef cookbook is used to ```go get && go install``` the go app.
- The opscode nginx community cookbook is used to configure nginx.
- Nginx is used as a reverse proxy and effectively a load balancer. Haproxy is my perference but...

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hello-world']['root_dir']</tt></td>
    <td>String</td>
    <td>The root directory of the application</td>
    <td><tt>/opt/hello-world</tt></td>
  </tr>
  <tr>
    <td><tt>['hello-world']['package_location']</tt></td>
    <td>String</td>
    <td>The golang package location</td>
    <td><tt>github.com/willejs/go-hello-world</tt></td>
  </tr>
  <tr>
    <td><tt>['hello-world']['nginx']['backends']</tt></td>
    <td>Array</td>
    <td>The backend servers in the nginx config</td>
    <td><tt>github.com/willejs/go-hello-world</tt></td>
  </tr>
</table>

## Usage
We use test kitchen to do everything, just run ```kitchen test```
It will run the suites and verify that the service has started and perform the nessisary tests

### hello-world::default
This will simply install the go binary in the bin directory of the GOROOT and start the service under upstart.

### hello-world::nginx
This will start a simple nginx instance and round robin proxy requests to the specified backends


## License and Authors

Author:: Will Salt (<williamejsalt@gmail.com>)
