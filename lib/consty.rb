class Consty
  
  VERSION = '0.1.0'

  class << self

    def get(name, namespace=Object)
      current_namespace = namespace
      while current_namespace do
       begin
         return secuential_get name, current_namespace
       rescue NameError
         namespace_name = current_namespace.name.split('::')[0..-2].join('::')
         current_namespace = namespace_name.empty? ? nil : secuential_get(namespace_name)
        end
      end
      namespace.const_missing name
    end

    private

    def secuential_get(name, namespace=Object)
      name_sections = name.to_s.split('::')
      
      if name_sections.first.empty?
        namespace = Object 
        name_sections = name_sections[1..-1]
      end

      name_sections.inject(namespace) { |c,n| c.const_get n }
    end

  end

end