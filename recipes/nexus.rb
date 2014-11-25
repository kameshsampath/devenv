#
# Author:: Kamesh Sampath (<kamesh.sampath@liferay.com>)
# Cookbook Name:: devenv
# Recipe:: nexus
#
# Copyright (c) 2014-present Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.

# install Apache Maven build tool

ark "maven" do
	url     "#{node['maven']['mirror_url']}/#{node['maven']['version']}/binaries/apache-maven-#{node['maven']['version']}-bin.tar.gz"
	version  node['maven']['version']
#	checksum node['maven']['checksum']
	append_env_path true
	action :install
end

ark "nexus" do
	url      "#{node['nexus']['dowload_url']}/nexus-#{node['nexus']['version']}-bundle.tar.gz"
	version  node['nexus']['version']
#	checksum "#{node['nexus']['checksum']}}"
	owner  node['nexus']['user']
	group node['nexus']['group']
	action :install
end

## update run as user for nexus
execute "Nexus RUN_AS_USER update" do 
 command "sed -i.bak 's/#RUN_AS_USER=/RUN_AS_USER=#{node['nexus']['user']}/' /usr/local/nexus/bin/nexus"
 user node['nexus']['user']
 group node['nexus']['group']
 action :nothing
 subscribes :run, "ark[nexus]", :immediately
end

## sonatype-work directory
directory "/usr/local/sonatype-work" do
  owner node['nexus']['user']
  group node['nexus']['group']
  :create
end 

# Nexus service
nexus_command = "/usr/local/nexus/bin/nexus console"
supervisor_service "nexus" do
	command         "#{nexus_command}"
	redirect_stderr  true
	stdout_logfile   '/var/log/supervisor/%(program_name)s_%(process_num)02d.log'
	autostart        true
	autorestart      false
	stopasgroup      true
	startretries     3
	startsecs        30
	stopwaitsecs     30
	user             "#{node['nexus']['user']}"
	action           [:enable]
end

## copy nexus.xml
cookbook_file "Nexus Configuration" do
  source "#{node['nexus']['version']}/nexus.xml"
  path "/usr/local/sonatype-work/nexus/conf/nexus.xml"
  owner node['nexus']['user']
  group node['nexus']['group']
  action :create
  notifies :restart, "supervisor_service[nexus]", :delayed
end


