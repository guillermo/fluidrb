module FluidDB
  class Resource < OpenStruct
    
    def head!(payload={}, uri_args={}, additional_headers = {})
      FluidDB.query(:head, @table[:path], payload, uri_args, additional_headers)
    end
  
    def put!(payload={}, uri_args={}, additional_headers = {})
      res = FluidDB.query(:put, @table[:path], payload, uri_args, additional_headers)
      merge_with_self(res)
      self
    end
  
    def get!(uri_args = {}, additional_headers = {})
      new_data = FluidDB.query(:get, @table[:path],{}, uri_args, additional_headers)
      merge_with_self(new_data)
    end
  
    def post!(payload={}, uri_args={}, additional_headers = {})
      res = FluidDB.query(:post, @table[:path], payload, uri_args, additional_headers)
      merge_with_self(res)
      update_path_from_uri
      self
    end
  
    def delete!(payload={}, uri_args={}, additional_headers = {})
      FluidDB.query(:delete, @table[:path], payload, uri_args, additional_headers)
    end
  
  private
    def merge_with_self(new_data)
      if new_data.is_a? Hash
        @table.merge!(new_data) 
      else
        @table.merge!(:value => new_data)
      end
    end
    
    def update_path_from_uri
      self.path = URI.parse(self.URI).path
    end
  end
end