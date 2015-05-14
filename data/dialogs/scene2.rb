# coding: utf-8

$dialogs[:scene2] = Dialog.new do |dialog|
    dialog.say "Сцена 2", :header
end

$dialogs[:scene2].extend StyledDialog
$dialogs[:scene2].extend Commands