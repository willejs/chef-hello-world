require_relative '../spec_helper'

describe 'hello-world::default' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }
  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.5 \"").and_return(0)
  end

  it 'installs the go-hello-world package' do
    expect(chef_run).to install_golang_package('github.com/willejs/go-hello-world')
  end

  it 'creates the hello-world upstart config file' do
    expect(chef_run).to create_template('/etc/init/hello-world.conf')
    resource = chef_run.template('/etc/init/hello-world.conf')
    expect(resource).to notify('service[hello-world]').to(:restart).delayed
  end

  it 'creates the helloworld user' do
    expect(chef_run).to create_user('helloworld')
  end

  it 'installs & starts the go-hello-world upstart service' do
    expect(chef_run).to enable_service('hello-world')
    expect(chef_run).to start_service('hello-world')
  end

end
