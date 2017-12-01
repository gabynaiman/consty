require_relative 'consty/version'

class Consty
  
  class << self

    def get(name, namespace=Object)
      current_namespace = namespace
      while current_namespace do
        begin
          return secuential_get name, current_namespace
        rescue NameError
          namespace_name = current_namespace.name ? current_namespace.name.split('::')[0..-2].join('::') : ''
          if !namespace_name.empty?
            current_namespace = secuential_get namespace_name
          elsif current_namespace != Object
            current_namespace = Object
          else
            current_namespace = nil
          end
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
      
      name_sections.inject(namespace) do |scope, section|
        if scope.constants.include?(section.to_sym)
          scope.const_get section
        else
          scope.const_missing section
        end
      end

    end

  end

end