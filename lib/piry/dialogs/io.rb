# coding: utf-8

class Dialog
  # Helpful methods for I/O
  module IO
    # Extended `puts` method
    # How to use:
    #
    #   say string, filter1, filter2, ...
    #
    # Examples:
    #
    #   say "Hello, ", :nnl
    #   say "World!"
    #
    def say(text = '', *list)
      if list.include? :nnl
        list.delete :nnl
      else
        text += "\n"
      end
      text = PIRY::Hooks::Manager.filter :say, text, list
      print text
    end

    # Safe gets
    def get
      gets.strip
    rescue Interrupt
      puts
      exit
    end

    # Same as `say` + `get`, but it may be with a block of code
    # Example:
    #
    #   ask 'What\'s your name?' do |name|
    #     puts "Hi, " + name
    #   end
    #
    # Will print:
    #
    #   What's your name? John
    #   Hi, John!
    #
    def ask(text)
      say text, :nnl
      answer = get
      if block_given?
        yield answer
      else
        answer
      end
    end

    # Method stopping dialog until user press enter to continue
    def press_enter(message = nil)
      if message
        say message, :nnl
      else
        say PIRY::Dialogs::Tools.dict[:press_enter_to_continue], :nnl
      end
      get
    end

    # Ask until a correct answer isn't
    # Example:
    #
    #   answer = ask_until ["Y", "n"]
    #   anotherAnswer = ask_until /^\d+$/
    #
    def ask_until(list)
      until (answer = check_answer list, (ask '? '))
        say PIRY::Dialogs::Tools.dict[:incorrect_choice]
      end
      answer
    end

    # Provide choice to user
    # Example:
    #
    #   select Hash[
    #	    "Say hi" => Proc.new do
    #       puts "Hi!"
    #     end,
    #	    "Say hello" => Proc.new do
    #       puts "Hello!"
    #	    end
    #	    ]
    #
    # Will print:
    #
    #   1. Say hi
    #   2. Say hello
    #   ? 1
    #   Hi!
    #
    def select(list)
      puts
      # List options
      list.keys.each_with_index do |key, number|
        say number.to_s + '. ' + key
        list[number] = list[key]
      end
      answer = ask_until list.keys
      answer = answer.to_i if answer =~ /^\d+$/
      puts
      list[answer].call
    end

    private

    # Check an answer in the list of the options
    def check_answer(list, answer)
      list = [list] if list.class != Array
      list.each do |correctAnswer|
        if  (correctAnswer.class == Regexp && answer =~ correctAnswer) ||
            (correctAnswer.class == Range && correctAnswer.include?(answer)) ||
            (correctAnswer.to_s =~ answer)
          return answer
        end
      end
      false
    end
  end
end
