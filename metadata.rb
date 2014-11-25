name		     "devenv"
maintainer       "Kamesh Sampath"
maintainer_email "kamesh.sampath@liferay.com"
license          "GNU LGPL v2.1 or later"
description      "Installs/Configures Development environment with nexus, maven etc.,"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ redhat fedora centos }.each do |os|
  supports os
end

depends "chef-sugar"
depends "ark", '~> 0.9.0'
depends "git"
depends "java", '~> 1.28.0'
depends 'supervisor', '~> 0.4.12'

