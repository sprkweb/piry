# coding: utf-8

# Data container class with ability to save and load from YAML files.
class DataContainer
  attr_accessor :autosave

  def initialize(file = nil)
    @data = {}
    @file = nil
    @autosave = false
    load file if file
  end

  def get(key)
    @data[key.to_s]
  end

  def set(key, value)
    @data[key.to_s] = value
    save if @autosave
  end

  def load(file)
    if File.exist? file
      @data = YAML.load_file file
      @file = file
    else
      false
    end
  end

  def save(filename = nil)
    filename = @file if @file && filename.nil?
    if filename
      File.open filename, 'w+' do |file|
        file.write @data.to_yaml
      end
    else
      false
    end
  end

  alias_method :[], :get
  alias_method :[]=, :set
end
