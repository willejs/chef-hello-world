require_relative '../spec_helper'

# the nginx cookbook has comprehensive unit tests, so im not going to repeat myself here,
# instead just test the resources I am creating.

describe 'hello-world::nginx' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }
  
  before do
    stub_command("which nginx").and_return(0)
  end

  it 'creates the hello-world nginx site config file' do
    expect(chef_run).to create_template('/etc/nginx/sites-available/hello-world')
    resource = chef_run.template('/etc/nginx/sites-available/hello-world')
    expect(resource).to notify('service[nginx]').to(:restart).immidiately
  end
end
