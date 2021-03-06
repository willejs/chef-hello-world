#
# Cookbook Name:: hello-world
# Recipe:: nginx
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

include_recipe 'nginx::default'

template '/etc/nginx/sites-available/hello-world' do
  source 'nginx/hello-world.erb'
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0644'
  variables(
    backends: node['hello-world']['nginx']['backends'],
    backend_port: node['hello-world']['nginx']['backend_port']
  )
  notifies :reload, 'service[nginx]', :immediately
end

nginx_site 'hello-world'
