# coding: utf-8

require 'lib/piry/dialogs/io'
require 'lib/piry/dialogs/tools'
require 'lib/piry/dialogs/dialog'

module PIRY
  # Dialogs manager for launching dialogs
  module Dialogs
    class DialogsManager
      include Singleton

      attr_accessor :next_dialog
      attr_writer :dialogs_path

      def dialogs
        @dialogs ||= {}
      end

      def launch_dialogs
        # Launch dialogs from the next_dialog variable
        while @next_dialog
          if dialogs.key? @next_dialog
            launch_the_dialog
          else
            break unless load_the_dialog dialog_name
          end
        end
      end

      private

      def launch_the_dialog
        now_dialog = @next_dialog
        @next_dialog = nil
        PIRY::Hooks::Manager.event :beforeDialog, now_dialog
        dialogs[now_dialog].start
      end

      def load_the_dialog(dialog_name)
        dialog_files = available_dialogs
        key = dialog_files.index do |file|
          file.include? dialog_name + '.rb'
        end
        if key
          require dialog_files[key]
        else
          false
        end
      end

      def available_dialogs
        Dir[dialogs_path + '/**/*.rb']
      end

      def dialogs_path
        @dialogs_path ||= ThePath + '/data/dialogs'
      end
    end

    Manager = DialogsManager.instance
  end
end
