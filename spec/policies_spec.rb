require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FluidDB::Policy do
  before(:all) do
    @policy = FluidDB::Policy.get('test/namespaces/create')
  end
  
  it "should be getted" do
    @policy.should be_kind_of(FluidDB::Policy)
  end
  
  it "should updated policy and exceptions" do
    @policy.update('open', ['test']).should == true
  end
  
  it "should update policy" do
    (@policy.policy = 'open').should == 'open'
    @policy.policy.should == 'open'
  end
  
  it "should update exceptions" do
    (@policy.exceptions = ['test']).should == ['test']
    @policy.exceptions.should == ['test']
  end
    
  it 'should have exceptions' do
    @policy.exceptions.should be_kind_of(Array)
  end
  
  it "should have a policy" do
    @policy.policy.should == 'open'
  end
  
end