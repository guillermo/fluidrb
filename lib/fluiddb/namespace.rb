module FluidDB
  class Namespace #:nodoc:
    
    def self.create!(namespace,description)
      path = namespace.split('/')[0..-2].join('/')
      name = namespace.split('/').last
      
      new_namespace = new(:path => '/namespaces/'+path)
      new_namespace.post!(:description => description, :name => name)
    end
    
    def self.find(namespace)
      new(:path => "/namespaces/#{namespace}").fetch
    end
    
    def fetch
      get!(:returnDescription => true, :returnNamespaces => true, :returnTags => true)
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

    def tags
      @table[:tagNames] || fetch
      @table[:tagNames]
    end
    
    def namespaces
      @table[:namespaceNames] || fetch
      @table[:namespaceNames] && @table[:namespaceNames].map do |n|
        Namespace.new(:path => @table[:path] + '/' + n)
      end
    end
  end
end
