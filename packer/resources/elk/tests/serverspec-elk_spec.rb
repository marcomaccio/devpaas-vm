require 'spec_helper'

describe package('elasticsearch'), :if => os[:family] == 'centos' do
  it { should be_installed }
end

describe package('elasticsearch'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe package('kibana'), :if => os[:family] == 'centos' do
  it { should be_installed }
end

describe package('kibana'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe package('logstash'), :if => os[:family] == 'centos' do
  it { should be_installed }
end

describe package('logstash'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end



