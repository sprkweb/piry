# coding: utf-8

require 'lib/piry/hooks'

class HooksTests < Test::Unit::TestCase
  def test_hook_call_and_its_data
    greeting = Hook.new Hash[:to => 'World'] do |message|
      'You have received a message: ' + message
    end
    greeting[:message] = proc do
      'Hello ' + greeting[:to] + '!'
    end
    assert_equal 'You have received a message: Hello World!',
                 (greeting.call greeting[:message])
  end
end

PiryTests << HooksTests.suite
