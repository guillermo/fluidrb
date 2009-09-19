require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Namespace do
  
  before(:all) do
    @name = generate_uniq
    @description = "description of #{@name}"
    @created_namespace = FluidDB::Namespace.create('test',{ :description => @description, :name => @name})
    @getted_namespace  = FluidDB::Namespace.get("test/#{@name}", :returnDescription => true)
  end
  

  it 'should be able to be created' do
    @created_namespace.should be_kind_of(FluidDB::Namespace)
  end
  
  it 'should be getted ' do
    @getted_namespace.should be_kind_of(FluidDB::Namespace)
  end

  it 'should raise if tried to find a non existing namespace' do
    lambda { FluidDB::Tag.get('test/wadus/wadus')}.should raise_error(FluidDB::Error)
  end
  
  
  describe 'on getted namespace' do
    it 'should be deleted' do
      name = generate_uniq('deleted')
      FluidDB::Namespace.create('test', :description => 'desc', :name => name)
      ns = FluidDB::Namespace.get("test/#{name}", :returnDescription => true, :returnNamespaces => true, :returnTags => true)
      ns.delete.should == true
    end

    it 'should have a namespace' do
      @getted_namespace.namespace.should == "test/#{@name}"
    end
    
    it 'should have a name' do
      @getted_namespace.name.should == @name
    end
    
    it 'should have a path' do
      @getted_namespace.path.should == "test/#{@name}"
    end
    
    it 'should have an id' do
      @getted_namespace.id.should match(FluidDB::Object::ID_FORMAT)
    end
    
    
    it 'should have a description' do
      @getted_namespace.description.should == @description
    end
    
    it 'should have namespaceNames' do
      @getted_namespace.namespaceNames.should == []
    end
    
    it 'should have tagNames' do
      @getted_namespace.tagNames.should == []
    end
  end
  
  describe 'on created namespace' do
    
    it 'should be deleted' do
      name = generate_uniq('deleted')
      ns = FluidDB::Namespace.create('test', :description => 'desc', :name => name)
      ns.delete.should == true
    end

    it 'should have a namespace' do
      @created_namespace.namespace.should == "test/#{@name}"
    end
    
    it 'should have a name' do
      @created_namespace.name.should == @name
    end
    
    it 'should have a path' do
      @created_namespace.path.should == "test/#{@name}"
    end
    
    it 'should have an id' do
      @created_namespace.id.should match(FluidDB::Object::ID_FORMAT)
    end
    
    
    it 'should have a description' do
      @created_namespace.description.should == @description
    end
    
    it 'should have namespaceNames' do
      @created_namespace.namespaceNames.should == []
    end
    
    it 'should have tagNames' do
      @created_namespace.tagNames.should == []
    end
  end
end