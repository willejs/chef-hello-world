require_relative '../spec_helper'

describe 'hello-world::default' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }

  it 'fetches the image and starts the container' do
    expect(chef_run).to run_docker_container('hello-world')
    expect(chef_run).to pull_docker_image('willejs/go-hello-world')
  end
end
