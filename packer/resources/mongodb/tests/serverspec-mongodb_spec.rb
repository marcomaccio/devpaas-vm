require 'spec_helper'

describe service('mongodb'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('mongod'), :if => os[:family] == 'centos' do
  it { should be_enabled }
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end
