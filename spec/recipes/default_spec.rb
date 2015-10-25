require_relative '../spec_helper'

describe 'backupserv::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('dev', description: 'test env')
      node.chef_environment = 'dev'
    end.converge described_recipe
  end
end
