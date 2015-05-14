# coding: utf-8

# Extended `Proc` object containing its data (e.g. priority of call which is
# used to calculate an order of call of hooks)
class Hook
  def initialize(options = {}, &hook)
    @data = {}
    @data[:priority] = 0.5
    @data.update options
    set(&hook) if block_given?
  end

  def set(&hook)
    @hook = hook
  end

  def call(*args)
    @hook.call(*args)
  end

  def []=(option, value)
    @data[option] = value
  end

  def [](option)
    @data[option].class == Proc ? @data[option].call : @data[option]
  end
end
