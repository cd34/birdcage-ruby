require "birdcage"
require "test/unit"

class Text < Test::Unit::TestCase  
  def test_text
    @l = Text.new ['a', 'bb', 'ccc', 'dddd']
  end
end
