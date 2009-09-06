module FluidDB 
  class Tag < Resource
    
    def self.create!(tag,description,indexed = true)
      path = tag.split('/')[0..-2].join('/')
      name = tag.split('/').last
      
      new_tag = new(:path => '/tags/'+path, :description => description, :indexed => indexed)
      new_tag.post!(:description => description, :name => name, :indexed => indexed)
    end
    
    def self.find(tag)
      new(:path => '/tags/'+tag).fetch
    end
    
    def fetch
      get!(:returnDescription => true)
      self
    end
      
    def update!(description)
      put!(:description=>description)
      self
    end
      
    def destroy!
      ret = delete!
      true
    end
    
  end
end