require_relative '../spec_helper'

describe 'default' do
  # ensure that the docker service has started
  describe service('docker') do
    it { should be_running }
  end

  # check that the bin has successfully compiled
  describe docker_container('hello-world') do
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
