require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Object do
  before(:all) do
    FDB::Tag.create!('test/opinion','opinion tag') rescue nil
  end
  
  it 'should create an Object' do
    about = generate_uniq
    o = FluidDB::Object.create!(:about => about)
  
    o.create!.should be_kind_of(FluidDB::Object)
    o.about.should == about
  end
  
  it 'should read and write tags' do
    o = FluidDB::Object.create!
    message = 'These is a "really good" object'
    o.test.opinion =  message
    
    (o / "test/opinion").should == message
    o.test.opinion.value.should == message
  end
  
  it 'should return tags' do
    about = generate_uniq
    obj = FluidDB::Object.create!(:about => about)
    obj.tags.each do |t|
      t.should be_kind_of(FluidDB::Object)
    end
  end
  
  it 'should find objects' do
    o = FluidDB::Object.create!(:about => 'a object with opinion')
    o.test.opinion = 'good opinion'
    
    objs = FluidDB::Object.find("has test/opinion").map{|o| o / "test/opinion"}
    objs.should be_include('good opinion')
  end
    
end