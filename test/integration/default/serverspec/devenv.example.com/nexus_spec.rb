require "serverspec"

set :backend, :exec

describe command('java -version') do
  its(:stdout) { should match /[java version\s*"1.7.0_67"]/ }
end

describe file('/usr/local/maven') do
  it { should be_directory }
end

describe command('/usr/local/maven/bin/mvn -v') do
  its(:stdout) { should match /Apache Maven 3.2.3/ }
end

describe file('/usr/local/nexus') do
  it { should be_directory }
end

describe port(8081) do
	it { should be_listening }
end

describe service("supervisord") do
	it { should be_running }
end

describe command(' sudo supervisorctl avail') do
  its(:stdout) { should match /nexus/ }
end

describe command('sudo supervisorctl status nexus') do
  its(:stdout) { should match /[nexus\s*RUNNING]/ }
end