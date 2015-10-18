# -*- encoding:utf-8 -*-
#
# EmoPhrase
#
#====================================================================
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "emo_phrase/version"
require "emo_phrase/collector"

module EmoPhrase

end

# TEST #============================================================
if __FILE__ == $0

db_file       = '../db/emo_phrase_20150901.sqlite3'
twitter_id_file  = "../doc/emo_trade_IDs_20150918.xlsx"

epc = ::EmoPhrase::Collector.new
epc.db = db_file
epc.twitter_id_list = twitter_id_file

#epc.count_linit = 4 #=> max 16 = 3200 tweets
#epc.start_row = 3
#epc.end_row   = 6
epc.twitter_access_backward("tadachi2_")
#epc.twitter_access("tadachi2_")
end

#=================================================================

