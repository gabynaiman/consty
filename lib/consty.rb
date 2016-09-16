class Consty
  
  VERSION = '0.1.0'

  def self.get(name, namespace=nil)
    current_namespace = namespace || Object
    while current_namespace do
      begin
        return current_namespace.const_get(name.to_s)
      rescue NameError
        namespace_name = current_namespace.name.split('::')[0..-2].join('::')
        current_namespace = namespace_name.empty? ? nil : Object.const_get(namespace_name.to_s)
      end
    end
    namespace.const_missing name
  end

end