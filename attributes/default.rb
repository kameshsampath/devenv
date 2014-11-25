#
# Author:: Kamesh Sampath (<kamesh.sampath@liferay.com>)
# Cookbook Name:: devenv
# Attributes:: default
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

##
# Nexus passwords
##

default['nexus']['admin']['username']          = 'admin'
default['nexus']['admin']['password']          = 'admin123'

default['nexus']['dowload_url']                = 'http://download.sonatype.com/nexus/oss/'
default['nexus']['version']                    = '2.10.0-02'
default['nexus']['checksum']                   = 'fb058fc57633c2ade52b093f32decaf33462ca78'
default['nexus']['user'] 					   = 'vagrant'
default['nexus']['group'] 					   = 'vagrant'

default['maven']['mirror_url']                 = 'http://psg.mtu.edu/pub/apache/maven/maven-3'
default['maven']['version']                    = '3.2.3'
default['maven']['checksum']                   = '2fcfdb327eb94b8595d97ee4181ef0a6'
