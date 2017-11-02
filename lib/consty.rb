require_relative 'consty/version'

class Consty
  
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
      
      name_sections.inject(namespace) do |namespace, section|
        if namespace.constants.include?(section.to_sym)
          namespace.const_get section
        else
          namespace.const_missing section
        end
      end

    end

  end

end