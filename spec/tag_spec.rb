require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Tag do

  before(:all) do
    @name = generate_uniq
    @description = "description of #{@name}"
    @created_tag = FluidDB::Tag.create('test', :description => @description, :indexed => true, :name => @name)
    @getted_tag  = FluidDB::Tag.get("test/#{@name}", :returnDescription => true)
  end
  
  it 'should be able to get a tag' do
    @getted_tag.should be_kind_of(FluidDB::Tag)
  end


  it 'should be create a tag in a namespaces' do
    @created_tag.should be_kind_of(FluidDB::Tag)
  end
  
  it 'should raise if tried to find a non existing tag' do
    lambda { FluidDB::Tag.get('test/wadus/wadus')}.should raise_error(FluidDB::Error)
  end
  
  describe 'on getted object' do
    it 'should have a namespace' do
      @getted_tag.namespace.should == 'test'
    end

    it 'should have a name' do
      @getted_tag.name.should == @name
    end

    it 'should have a path' do
      @getted_tag.path.should == "test/#{@name}"
    end

    it 'should have a description' do
      @getted_tag.description.should == @description
    end
    
    it 'should have indexed option' do
      @getted_tag.indexed?.should == true
    end
    
    it 'should have id' do
      @getted_tag.id.should match(FluidDB::Object::ID_FORMAT)
    end
  
  end
  
  describe 'on created object' do
    it 'should have a namespace' do
      @created_tag.namespace.should == 'test'
    end

    it 'should have a name' do
      @created_tag.name.should == @name
    end

    it 'should have a path' do
      @created_tag.path.should == "test/#{@name}"
    end

    it 'should have a description' do
      @created_tag.description.should == @description
    end

    it 'should have indexed option' do
      @created_tag.indexed?.should == true
    end
    
    it 'should have id' do
      @created_tag.id.should match(FluidDB::Object::ID_FORMAT)
    end
  end
  
  
  it 'should raise an error if try to get a description whitout explicity getting description' do
    lambda { 
      tag = FluidDB::Tag.get(@name)
      tag.description
    }.should raise_error(FluidDB::Error)
  end
  
  it 'should edit description' do
    name = generate_uniq+"2"
    tag = FluidDB::Tag.create('test', :description => 'my description', :indexed => true, :name => name)
    tag.description = 'wadus wadus description'
    tag.description.should == 'wadus wadus description'
    
    tag = FluidDB::Tag.get("test/#{name}", :returnDescription => true)
    tag.description.should == 'wadus wadus description'
  end
  
  it 'should be deleted' do
    name = generate_uniq+"3"
    tag = FluidDB::Tag.create('test', :description => 'my description', :indexed => true, :name => name)
    tag.delete.should == true
  end
  
end