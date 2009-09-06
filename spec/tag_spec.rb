require File.join(File.dirname(__FILE__),'spec_helper')

describe FluidDB::Tag do
  
  it 'should be able to find' do
    name = generate_uniq
    FluidDB::Tag.create!("test/#{name}",'description')
    
    tag = FluidDB::Tag.find("test/#{name}")
    tag.should be_kind_of(FluidDB::Tag)
    tag.description.should == 'description'
  end
  
  it 'should create a new tag' do
    name = generate_uniq
    tag = FluidDB::Tag.create!("test/#{name}",'description')
    
    tag.should be_kind_of(FluidDB::Tag)
    tag.description.should == 'description'
    tag.indexed.should == true
  end
  
  it 'should edit a tag' do
    name = generate_uniq
    tag = FluidDB::Tag.create!("test/#{name}",'description')
    
    tag.update!('new description')
    FluidDB::Tag.find("test/#{name}").description.should == 'new description'
  end
  
  it 'should remove a tag' do
    name = generate_uniq
    tag = FluidDB::Tag.create!("test/#{name}",'description')
    tag.destroy!.should == true
  end

  describe 'should raise error' do
    it 'on create if already exists' do
      name = generate_uniq
      tag = FluidDB::Tag.create!("test/#{name}",'description')
      
      lambda{ FluidDB::Tag.create!("test/#{name}",'description') }.should raise_error( FluidDB::Error )      
    end
    
    it 'on remove if no exists' do
      name = generate_uniq
      tag = FluidDB::Tag.create!("test/#{name}",'description')
      tag.destroy!.should == true
      lambda{ tag.destroy! }.should raise_error( FluidDB::Error)
    end
  end
  
end