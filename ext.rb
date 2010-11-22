# Require all helpers
Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each {|file| require file }

class Hash
  def symbolize
    accum = {}
    self.each {|k, v| accum[k.to_sym] = v }
    accum
  end
end

class Page < Struct.new :filename, :header, :body; end

def parse(file)
  # Parses a file; grabs YAML out of the header as well as the rest of the document.
  # Tries to guess format and pre-renders if it can figure it out.
  
  contents = File.read(file) {|f| f.read }
  whole_file_unless_header, header_if_header, body_if_header = contents.split(/^---\s*\n(.+)\s*\n---\n/m) # Pull out the YAML header
  # https://github.com/mojombo/jekyll/blob/master/lib/jekyll/convertible.rb line 26 for YAML header parsing inspiration.
  # Build a response in the format: [file path, options from YAML header, raw data after the header]
  if header_if_header && body_if_header # If the header is found.
    resp = Page.new file, YAML::load(header_if_header).symbolize, body_if_header
  else
    resp = Page.new file, {}, whole_file_unless_header
  end

  raise "Page header must be a hash" unless resp.header.is_a? Hash
  
  # Build a scope of options from the header
  scope = Object.new
  resp.header.each do |k, v|
    scope.instance_variable_set("@#{k}".to_sym, v)
  end
  # Guess the format.
  if resp.filename =~ /haml$/
    resp.body = Haml::Engine.new(resp.body).render scope # Render the raw data with the scope
  else
    resp.body = ERB.new(resp.body).result(scope.instance_eval { binding })
  end
  
  resp.header[:path] = File.basename(resp.filename).split('.').first unless resp.header.has_key? :path
  
  resp
end