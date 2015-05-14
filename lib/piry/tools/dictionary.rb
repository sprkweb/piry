# coding: utf-8

# Dictionary is a tool for loading and using language files.
class Dictionary < DataContainer
  undef_method :[]=, :set
end
