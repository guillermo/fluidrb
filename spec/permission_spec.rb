require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FluidDB::Permission do
  before(:all) do
    name = generate_uniq("permissions")
    @permission = FluidDB::Permission.get("namespaces/test",:action => 'create')  
  end
  
  it "should be getted" do
    @permission.should be_kind_of(FluidDB::Permission)
  end
  
  it "should have exceptions" do
    @permission.exceptions.should == ['test']
  end
  
  it "should have policy" do
    @permission.policy.should == 'closed'
  end
  
  it "should have a resource" do
    @permission.resource.should == 'namespaces/test'
  end
  
  it "should be updated" do
    @permission.update('update', ["test"], 'open').should == true
  end
end