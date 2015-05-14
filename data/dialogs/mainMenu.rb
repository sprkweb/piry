# coding: utf-8

Dialogs[:mainMenu] = Dialog.new do
  puts
  say " Тарона ", :header
  select Hash[
    "Новая игра" => Proc.new do
      $nextDialog = :scene1
      $game = Session.new
    end,

    "Загрузить" => Proc.new do
      $game = Session.new
      if not $game.load Paths["data"] + "/saves/save"
        say "Сохранение не найдено."
      end
      $nextDialog = $game.data['dialog'].to_sym
    end,

    "Об игре" => Proc.new do
      say "Об игре", :header
      say "\"Тарона\" — IF произведение (Interactive Fiction; интерактивная литература) в жанре приключенческого фентези. Здесь нет характеристик или вещей, вы просто делаете читаете книгу и делаете выбор, который, возможно, повлияет на развитие событий."
      say "Перед началом настоятельно рекомендую почитать инструкцию."
      say "Текст интерактивной книги предоставляется по лицензии CC BY 4.0, код — по MIT License. Это значит, что вы можете и с тем, и с другим, а так же с их частями делать что хотите: скачивать, распространять, и модифицировать, пока вы признаете меня автором этого произведения и пишете об этом (в виде копирайта и текста лицензии из файла LICENSE) во всех распространенных, измененных копиях/частях произведения, а так же во всем, основанном или использующем их. Подробнее написано в файле LICENSE в папке с игрой."
      $nextDialog = :mainMenu
    end,

    "Настройки" => Proc.new do
      say "Настройки", :header
      select Hash[
        "Цвета" => Proc.new do
          select Hash[
            "Терминал" => Proc.new do
              sett.set "colors", "plain"
            end,
            "Стандартный" => Proc.new do
              sett.set "colors", "default"
            end,
            "Белый фон" => Proc.new do
              sett.set "colors", "white_bg"
            end,
            "Черный фон" => Proc.new do
              sett.set "colors", "dark_bg"
            end
            ]
        end
        ]
      sett.save
      sett.apply
      $nextDialog = :mainMenu
    end,

    "Инструкции" => Proc.new do
      say "Инструкции", :header
      say "Комманды для управления игрой, могут вводиться вместо выбора во время игры:"
      say (colorizeThat "exit", :highlight) + " - выйти из игры. Рекомендуется использовать только после save."
      say
      say "Выбранная цветовая схема (см. Настройки):"
      say   (colorizeThat "Выделенный текст", :highlight) + "; " +
            (colorizeThat "Обычный текст", :text) + "; " +
            (colorizeThat "Заголовок", :header) + "; " +
            (colorizeThat "Слова протагониста", :protagonist) + "; " +
            (colorizeThat "Слова других", :phrase)
      say
      say "Игра автоматически сохраняется при начале каждой сцены (я разделяю игру на главы, а главы на сцены), так что когда выходите из игры, прогресс с начала текущей сцены будет потерян. Но не бойтесь, сцены всегда довольно короткие, а потому сохранения будут часто."
      $nextDialog = :mainMenu
    end,

    "Выход" => Proc.new do
      $nextDialog = :none;
    end
    ]
end

Dialogs[:mainMenu].extend StyledDialog
Dialogs[:mainMenu].extend Commands
