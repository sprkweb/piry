# coding: utf-8

require 'lib/piry/hooks/hook'
require 'lib/piry/hooks/hooks_group'

module PIRY
  # This is the object for launching events and filtering texts
  module Hooks
    class HooksManager
      include Singleton

      def initialize
        @callbacks = {}
        @filters = {}
      end

      # Events
      # Structure of events:
      #
      #   @variable = {
      #     :event => HooksGroup [
      #         Hook.new,
      #         Hook.new
      #       ],
      #     :anotherEvent => HooksGroup [
      #     ...
      #   }
      #

      def event(id, *args)
        return unless @callbacks.key? id
        @callbacks[id.to_sym].conscription.each do |hook|
          hook.call(*args)
        end
      end

      def callback(id, hook = nil)
        id = id.to_sym
        @callbacks[id] = HooksArray.new unless @callbacks.key? id
        if hook.class == Hook || hook.class.superclass == AbstractHooksGroup
          @callbacks[id].add hook
        elsif block_given?
          @callbacks[id].add Hook.new(&Proc.new)
        else
          false
        end
      end

      # Filters
      # Structure of filters:
      #
      #   @variable = {
      #     :group => HooksGroup {
      #       :filter => Hook.new,
      #       ...
      #     },
      #     :anotherGroupOfFilters => HooksGroup {
      #     ...
      #   }
      #

      def filter(group, text, list)
        group = group.to_sym
        if @filters.key? group
          (@filters[group].conscription list).each do |hook|
            text = hook.call text
          end
        end
        text
      end

      def new_filter(group, name, hook = nil)
        group = group.to_sym
        name = name.to_sym
        @filters[group] = HooksHash.new unless @filters.key? group
        if hook.class == Hook || hook.class.superclass == AbstractHooksGroup
          @filters[group].add name, hook
        elsif block_given?
          @filters[group].add name, Hook.new(&Proc.new)
        else
          false
        end
      end
    end

    Manager = HooksManager.instance
  end
end
