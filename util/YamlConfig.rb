
class YamlConfig
  def initialize( file )
    load( file )
  end
  
  def load( file )
    @config = YAML.load_file( file )
    return @config
  end
  
  def override( file )
    if File.exists?( file )
      local = YAML.load_file( file )
      merge( @config, local )
    else
      puts "Could not load override #{file}"
    end
    return @config
  end
  
  def merge( orig, override )
    override.each_key do |key|
      if override[key].is_a? Hash and orig.has_key? key and orig[key].is_a? Hash
        self.merge( orig[key], override[key] )
      else
        orig[key] = override[key]
      end
    end
  end

end