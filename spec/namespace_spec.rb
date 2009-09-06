require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Namespace do
  
  it 'should find the user namespace' do
    FluidDB::Namespace.find('test').should be_kind_of(FluidDB::Namespace)
  end
  
  it 'should create a new namespace' do
    name = generate_uniq
    FluidDB::Namespace.create!("test/#{name}",'description').should be
  end
    
  it 'should edit namespace' do
    name = generate_uniq
    ns = FluidDB::Namespace.create!("test/#{name}",'description')
    ns.update!('another description')
    ns.fetch.description.should == 'another description'
  end
  
  it 'should remove namespaces' do
    name = generate_uniq
    ns = FluidDB::Namespace.create!("test/#{name}",'description')
    ns.destroy!.should == true
  end
  
  describe 'should raise error' do
    it 'on create if already exists' do
      name = generate_uniq
      FluidDB::Namespace.create!("test/#{name}",'description')
      lambda{ FluidDB::Namespace.create!("test/#{name}",'description') }.should raise_error( FluidDB::Error )      
    end
    
    it 'on remove if no exists' do
      name = generate_uniq
      ns = FluidDB::Namespace.create!("test/#{name}",'description')
      ns.delete!
      lambda{ ns.delete! }.should raise_error( FluidDB::Error )
    end
  end
  
end