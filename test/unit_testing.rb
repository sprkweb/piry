require 'singleton'
require 'test/unit'
require 'test/unit/ui/console/testrunner'

$LOAD_PATH << File.dirname(File.expand_path(File.dirname(__FILE__)))

class PiryTests
  def self.suite
    @@suite ||= Test::Unit::TestSuite.new 'Piry tests'
  end

  def self.<<(test)
    suite << test
  end
end

Dir.glob 'test/**/*_test.rb' do |filename|
  require filename
end

Test::Unit::UI::Console::TestRunner.run PiryTests
