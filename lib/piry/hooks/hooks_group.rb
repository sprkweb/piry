# coding: utf-8

# Abstact class whose instances contain events/filters
class AbstractHooksGroup
  def initialize(list)
    @list = list
  end

  def conscription(_recruitsList)
  end

  def add
  end
end

# All hooks in this container have their own names, so we will conscript
# (`conscription` method) only those whose names are in the array
# (`recruits_list`)
class HooksHash < AbstractHooksGroup
  attr_accessor :default, :always

  def initialize(list = nil)
    if list
      @list = list
    else
      @list = {}
    end
    @default = []
    @always = []
  end

  def conscription(recruits_list)
    recruits = []
    recruits_list = @default if recruitsList.size == 0
    recruits_list += @always
    @list.each do |name, man|
      if man.class == Hook && (recruits_list.include? name)
        recruits << man
      elsif man.class.superclass == AbstractHooksGroup
        recruits += man.conscription recruitsList
      end
    end
    recruits.sort_by(&:priority).reverse
  end

  def add(name, hook, *options)
    @list[name] = hook
    if options.include? :always
      @always << name
    elsif options.include? :default
      @default << name
    end
  end
end

# All hooks in this container haven't names, so all hooks will be conscripted.
class HooksArray < AbstractHooksGroup
  def initialize(list = nil)
    if list
      @list = list
    else
      @list = []
    end
  end

  def conscription(_recruitsList = nil)
    @list.sort_by(&:priority).reverse
  end

  def add(hook)
    @list << hook
  end
end
