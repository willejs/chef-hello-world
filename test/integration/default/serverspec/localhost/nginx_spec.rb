require_relative '../spec_helper'

describe 'nginx' do
  # make sure the file that nginx enables is there.
  describe file('/etc/nginx/sites-enabled/hello-world') do
    it { should exist }
  end

  # check that the nginx service is running, it wont if the config has failed to reload
  describe service('nginx') do
    it { should be_running }
  end

  # check if nginx is listening on port 80
  describe port(80) do
    it { should be_listening.with('tcp') }
  end

  # we dont have curl installed so test that its serving on port 80
  describe command('wget -o /dev/null localhost:80') do
    its(:exit_status) { should eq 0 }
  end
end
