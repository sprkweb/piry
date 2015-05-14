# coding: utf-8

# The module provides ability to user to run predefined commands when the `ask`
# method is asking. See examples for more.
module Commands
  # Run command if it is called
  def ask(text)
    say text, :nnl
    answer = get
    if Settings.instance.group[:commands].key? answer
      Settings.instance.group[:commands][answer].call
    elsif block_given?
      yield answer
    else
      answer
    end
  end
end
