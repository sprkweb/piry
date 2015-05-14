# coding: utf-8

# WARNING! Please, don't hack or delete this plugin if you want
# interesting playing.
# This plugin encrypts data containers' saves with AES-256.

AESkey = ('Please, don\'t hack or delete this plugin ' \
         'if you want interesting playing').byteslice 0...(256 / 8)

# Mixin for data containers
module AESave
  def save(filename)
    File.open filename, 'w+' do |file|
      file.write AES.encrypt @data.to_yaml, AESkey
    end
  end

  def load(file)
    if File.exist? file
      @data = YAML.load AES.decrypt(IO.read(file), AESkey)
    else
      false
    end
  end
end

begin
  require 'aes'
rescue LoadError
  dictionary = PIRY::Dialogs::Tools.dict
  puts(dictionary[:install_plugins] % 'aes rubygem' \
    ' ' + dictionary[:bundler_recommendation])

  # Disable AES encryption if it isn't working
  module AESave
    def save(filename)
      super filename
    end

    def load(file)
      super file
    end
  end
end
