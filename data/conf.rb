# coding: utf-8

# Your project's configuration file

PIRY::Dialogs::Manager.next_dialog = :mainMenu

# Here are configuration, which will applied after plugins load
PIRY::Hooks::Manager.callback :afterPluginsLoad do

  # This is prototype - dialog without any actions. It is only used
  # as a model to inherit from it other dialogs.
  PIRY::Dialogs::Manager[:mainPrototype] = Dialog.new
  PIRY::Dialogs::Manager[:mainPrototype].extend StyledDialog
  PIRY::Dialogs::Manager[:mainPrototype].extend Commands
end

settings = Settings.new ThePath + '/data/settings/settings.yml'

# Plugins configuration

settings.configuration :choose_color_scheme, :colors do
  # Here are configuration, which may vary depending on the settings
  PIRY::Manager[:styles] =
    case settings[:colors]
    when 'plain'
      {
        :header =>      [],
        :protagonist => [],
        :phrase =>      [],
        :highlight =>   [],
        :text =>        []
      }
    when 'white_bg'
      {
        :header =>      [:bold, :white, :on_green],
        :protagonist => [:green, :on_white],
        :phrase =>      [:blue, :on_white],
        :highlight =>   [:underline, :on_white],
        :text =>        [:black, :on_white]
      }
    when 'dark_bg'
      {
        :header =>      [:bold, :white, :on_green],
        :protagonist => [:on_black],
        :phrase =>      [:blue, :on_black],
        :highlight =>   [:underline, :on_black],
        :text =>        [:white, :on_black]
      }
    else
      {
        :header =>      [:bold, :white, :on_green],
        :protagonist => [:green],
        :phrase =>      [:blue],
        :highlight =>   [:underline],
        :text =>        []
      }
    end
end
PIRY::Manager[:commands] = {
  :exit => proc do
    exit
  end
}
