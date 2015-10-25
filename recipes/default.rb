#
# Cookbook Name:: hello-world
# Recipe:: default
#
# Copyright (C) 2015 Will Salt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'golang'

# go get the hello-world golang service, compile and install it.
golang_package node['hello-world']['package_location']

# create a simple user to run the daemon as, not considering it writing files as it should be a 12factorapp.
user node['hello-world']['user'] do
  action :create
  system true
end

# create the upstart service config from a template
template '/etc/init/hello-world.conf' do
  source 'upstart/hello-world.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    user: node['hello-world']['user'],
    exec_command: node['hello-world']['exec_command']
  )
  notifies :restart, 'service[hello-world]', :delayed
end

# set up the service as an upstart job
service 'hello-world' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end
