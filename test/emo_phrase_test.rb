require 'test_helper'

class EmoPhraseTest < Minitest::Test
  def setup
    db_file       = 'db/emo_phrase.sqlite3'
    twitter_id_file  = "doc/emo_trade_IDs_20150817.xlsx"

    @epc = ::EmoPhrase::Collector.new
    @epc.db = db_file
    @epc.twitter_id_list = twitter_id_file

  end

  def test_that_it_has_a_version_number
    refute_nil ::EmoPhrase::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_twitter_access
    user_id = "tadachi2_"
    @epc.twitter_access_backward(user_id)

  end
end
