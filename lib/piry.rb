# coding: utf-8

require 'singleton'
require 'yaml'

require 'lib/piry/hooks'

require 'lib/piry/tools/data_container'
require 'lib/piry/tools/dictionary'
require 'lib/piry/tools/settings'

require 'lib/piry/dialogs'

require 'conf/conf'

# Namespace for various PIRY's data/objects/something else managers
module PIRY
  # This is the main object loading and launching all others components
  class PiryManager
    include Singleton

    def launch
      require_plugins ThePath + '/plugins'
      PIRY::Hooks::Manager.event :afterPluginsLoad

      require 'data/conf'

      PIRY::Hooks::Manager.event :start
    end

    def exit
      PIRY::Hooks::Manager.event :exit
      exit
    end

    # Container for various configurable data
    # such as styles for colorize plugin
    def [](key)
      data[key.to_s]
    end

    def []=(key, value)
      data[key.to_s] = value
    end

    private

    # Plugins

    def find_plugins(plugins_path)
      Dir[plugins_path + '/**/*_plugin.rb']
    end

    def require_plugins(plugins_path)
      (find_plugins plugins_path).each do |file|
        require file
      end
    end

    def data
      @data ||= {}
    end
  end

  Manager = PiryManager.instance
end
