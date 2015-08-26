require 'test_helper'

class EmoPhraseTest < Minitest::Test
  def setup
    @epc = ::EmoPhrase::Collector.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::EmoPhrase::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
