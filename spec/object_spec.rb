require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Object do
  before(:all) do
    begin
      FluidDB.connection.post('/tags/test',:payload => {:description => '',:indexed => true, :name => 'opinion'}) 
    rescue FluidDB::Error
    end

    @about = generate_uniq
    @created_object  = FluidDB::Object.create(:about => @about)
    @getted_object   = FluidDB::Object.get(@created_object.id)
  end
    
  it 'should be created' do
    @created_object.should be_kind_of(FluidDB::Object)
  end

  it 'should have id' do
    @created_object = FluidDB::Object.create(:about => @about)
    
    @created_object.id.should match(FluidDB::Object::ID_FORMAT)
  end
  
  it 'should have about' do
    @getted_object.about.should == @about
  end
  
  it 'should have tag_paths' do
    @getted_object.tag_paths.should be_include("fluiddb/about")
  end
  
  it 'should be getted' do
    @getted_object.should be_kind_of(FluidDB::Object)
  end
  
  it 'should write and read a tag' do 
    @getted_object.write_tag('test/opinion',10).should == 10
    @getted_object.read_tag('test/opinion').should == 10
  end
  
  it 'should remove a tag' do
    @getted_object.write_tag('test/opinion')
    @getted_object.remove_tag('test/opinion')
    lambda{ @getted_object.read_tag('test/opinion') }.should raise_error(FluidDB::Error)
  end
  
  it 'should check if a tag exists' do
    @getted_object.write_tag('test/opinion')
    @getted_object.have_tag?('test/opinion').should == true
    @getted_object.remove_tag('test/opinion')
    @getted_object.have_tag?('test/opinion').should == false
  end
      
end  