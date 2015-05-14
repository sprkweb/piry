# coding: utf-8

require 'lib/piry/dialogs'

class DialogsTests < Test::Unit::TestCase
  def test_dialogs_blocks
    result = ''
    dialog = Dialog.new do
      block 1 do
        result = 'it should be redefined in the third block'
        next_block 3
      end
      block 2 do
        result = 'foo'
      end
      block 3 do
        result[' should be'] = ''
      end
      blocks_start 1
    end
    dialog.start
    assert_equal 'it redefined in the third block', result
  end

  def test_tools_set_and_get
    results = []
    tools = PIRY::Dialogs::Tools
    tools[:greeting] = {
      :hello => 'Hello',
      :hey => 'Hey',
      :good_bye => 'Good bye'
    }
    results << tools.greeting.reverse
    results << tools.greeting(:good_bye).downcase
    tools[:greeting].default = tools[:greeting][:hey]
    results << tools.greeting.reverse.downcase
    assert_equal ['olleH', 'good bye', 'yeh'], results
  end
end

PiryTests << DialogsTests.suite
