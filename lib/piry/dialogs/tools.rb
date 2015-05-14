# coding: utf-8

module PIRY
  module Dialogs
    # Manager for tools, grouped in methods by some sign (usually it is class).
    # Tool is a useful object for use in dialogs.
    # For example:
    #
    #   tool = SomeClass.new
    #   PIRY::Dialogs::Tools[:myTool] = tool
    #
    # Then, you may use this tool in dialogs just like variable.
    #
    #   myTool.someAction
    #
    class ToolsManager
      include Singleton

      def tools
        @tools ||= {}
      end

      def []=(group, hash)
        group = group.to_sym
        if hash.class != Hash
          hash = {:default => hash}
        end
        tools[group] = hash
        tools[group].default = (hash.first)[1]
        new_group group
      end

      def [](group)
        @tools[group]
      end

      private

      def new_group(group)
        define_singleton_method group.to_sym do |tool = nil|
          if tool
            @tools[group][tool.to_sym]
          else
            @tools[group].default
          end
        end
      end
    end

    Tools = ToolsManager.instance
  end
end
