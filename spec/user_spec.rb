require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::User do
  before(:all) do
    @user = FluidDB::User.get('test')
  end
  
  it 'should return an User if exists' do
    @user.should be_kind_of(FluidDB::User)
  end
  
  it 'should have username' do
    @user.username.should == 'test'
  end
  it "should have name" do
    @user.name == 'test'
  end
  
  it 'should have an id' do
    @user.id.should match(FluidDB::Object::ID_FORMAT)
  end
  
  it 'should raise an error if an User doesn\'t exists' do
    lambda { FluidDB::User.get('probablyanonexistinguser') }.should raise_error(FluidDB::Error)
  end
end