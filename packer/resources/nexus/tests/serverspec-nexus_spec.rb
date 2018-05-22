require 'spec_helper'

describe service('nexus'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(8081) do
  it { should be_listening }
end
