# coding: utf-8

begin
  require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
rescue LoadError
  dictionary = PIRY::Dialogs::Tools.dict
  puts(dictionary[:install_plugins] % 'win32console, colorize rubygems' \
    ' ' + dictionary[:bundler_recommendation])
else
  require 'plugins/colors/color_scheme'
  require 'plugins/colors/manager'

  module StyledDialog
    def colorize(text, color_scheme)
      Dialog::IO::Colors.colorize text, color_scheme
    end
  end
  
  colors_filters = Hash.new
  Dialog::IO::Colors.color_schemes.keys.each do |scheme_name|
    colors_filters[scheme_name] = Hook.new do |text|
      colorize text, scheme_name
    end
  end
  colors_filters = HooksHash.new colors_filters
  colors_filters.default = [:text]
  PIRY::Hooks::Manager.new_filter :say, :colors, colors_filters

  PIRY::Hooks::Manager.callback :exit do
    print Dialog::IO::ColorsManager::END_ESC_CODE
  end
end
