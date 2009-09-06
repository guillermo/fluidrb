require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::User do
  
  it 'should return an User if exists' do
    u = FluidDB::User.find('test')
    u.should be_kind_of(FluidDB::User)
    u.name.should == 'test'
  end
  
  it 'should raise an error if an User doesn\'t exists' do
    lambda { FluidDB::User.find('probablyanonexistinguser') }.should raise_error (FluidDB::Error)
  end
end