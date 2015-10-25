require_relative '../spec_helper'

describe 'default' do
  # check that the bin has successfully compiled
  describe file('/etc/nginx/sites-enabled/hello-world') do
    its(:content) { should match(/10.10.0.11/) }
    its(:content) { should match(/10.10.0.12/) }
  end
end
