module ConfigurationClass
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def config_object(name, accessor, *methods)
      k = Class.new do
        attr_accessor *methods
      end
      self.class.const_set(name, k)

      class_eval <<-EOS
        #class #{name}
        #  attr_accessor *#{methods.inspect}
        #end

        def #{accessor}
          @#{accessor} ||= #{name}.new
          yield @#{accessor} if block_given?
          @#{accessor}
        end
      EOS

      #define_method accessor do
      #  instance_variable_set("@#{accessor.to_s}".to_sym, const_get(name).new) unless instance_variable_get("@#{accessor.to_s}".to_sym)
      #  yield instance_variable_get(accessor) if block_given?
      #  instance_variable_get(accessor)
      #end
    end
  end
end




#class AppServer
#  attr_accessor :port, :admin_password
#end

class Configuration
  attr_accessor :tail_logs, :max_connections, :admin_password

  include ConfigurationClass
  config_object :AppServer, :app_server, :port, :admin_password
  config_object :NameServer, :name_server, :port, :admin_password
end


def configure(&block)
  config = Configuration.new
  block.call(config)
  config
end


### Just runs the 'tests' and prints results

configuration = configure do |config|  
  config.tail_logs = true  
  config.max_connections = 55  
  config.admin_password = 'secret'  
  config.app_server do |app_server_config|  
    app_server_config.port = 8808  
    app_server_config.admin_password = config.admin_password  
  end  
end  


puts configuration.class #=> Configuration  
puts configuration.tail_logs #=> true  
puts configuration.app_server.admin_password #=> 'secret'  

pass = true
pass &&= configuration.class == Configuration
pass &&= configuration.tail_logs == true
pass &&= configuration.app_server.admin_password == 'secret'

puts "\nResult: #{pass ? '\o/' : ':('}"
