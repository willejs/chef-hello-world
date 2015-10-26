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

docker_service_upstart 'default' do
  action [:create, :start]
  version '1.8.3'
end

# pull down the latest image
docker_image 'willejs/go-hello-world'

# start the container and map it to port 8484
docker_container 'hello-world' do
  image 'willejs/go-hello-world'
  port '8484:8484'
  detach true
  tag 'latest'
  user node['hello-world']['user']
end
