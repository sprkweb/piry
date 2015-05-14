# coding: utf-8

# Settings consist of two things: data container and some actions depending
# on the data.
class Settings < DataContainer
  def initialize(file = nil)
    super file
    @rules = {}
  end

  def configuration(rule_name, *affect_settings, &rules)
    rule_name = rule_name.to_sym
    @rules[rule_name] = rules
    apply rule_name
    affect_settings.each do |setting|
      new_dependence rule_name, setting
    end
  end

  def apply(id)
    @rules[id.to_sym].call
  end

  def set(key, value)
    super key, value
    PIRY::Hooks::Manager.event(('setting_' + key.to_s + '_changed').to_sym)
  end

  private

  def new_dependence(rule_name, setting)
    callback_name = ('setting_' + setting.to_s + '_changed').to_sym
    PIRY::Hooks::Manager.callback callback_name do
      apply rule_name
    end
  end

  alias_method :[]=, :set
end
