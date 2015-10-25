require_relative '../spec_helper'

describe 'default' do
  describe file('/opt/go/bin/go-hello-world') do
    it { should exist }
  end

  describe file('/etc/init/hello-world.conf') do
    it { should exist }
  end

  describe user('helloworld') do
    it { should exist }
  end

  describe service('hello-world') do
    it { should be_running }
  end

  describe port(8484) do
    it { should be_listening.with('tcp6') }
  end

  describe command('wget -o /dev/null localhost:8484') do
    its(:exit_status) { should eq 0 }
  end
end
