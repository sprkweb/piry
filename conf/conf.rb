
# # Default session && its data
# main_session = Session.new Paths[:data] + '/saves/save'
# hooksManager.callback :beforeDialog do |id|
#   main_session[:dialog] = id
# end
# hooksManager.callback :beforeBlock do |id|
#   main_session[:block] = id
# end

# Default tools

# Main dictionary is used to print PIRY's messages.
# You may change language with `load` method if you want.
# You may either create your own separated dictionary or use this to
# print your messages.
main_dictionary = Dictionary.new ThePath + '/data/lang/en.yml'
PIRY::Dialogs::Tools[:dict] = main_dictionary
