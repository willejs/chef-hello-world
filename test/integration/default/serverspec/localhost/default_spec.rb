require_relative '../spec_helper'

describe 'default' do
  # check that the bin has successfully compiled
  describe file('/opt/go/bin/go-hello-world') do
    it { should exist }
  end

  # check that the upstart config exists
  describe file('/etc/init/hello-world.conf') do
    it { should exist }
  end

  # check the user has been created
  describe user('helloworld') do
    it { should exist }
  end

  # ensure that the service has started
  describe service('hello-world') do
    it { should be_running }
  end

  # check that the service is listening on its port
  describe port(8484) do
    it { should be_listening.with('tcp6') }
  end

  # check its serving http
  describe command('wget -o /dev/null localhost:8484') do
    its(:exit_status) { should eq 0 }
  end
end
