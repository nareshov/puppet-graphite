require 'spec_helper'
 
describe 'graphite_reporter', :type => :class do

  it { should create_class('graphite_reporter') }
  it { should contain_file('/etc/puppet/graphite.yaml') }

end

