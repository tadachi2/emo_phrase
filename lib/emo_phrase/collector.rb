# -*- encoding:utf-8 -*-
#
# Emophrase::Collector.rb
#
#=========================================================================

require "rubyXL"
require "emo_phrase/database"
require "emo_phrase/xlsx"
require "emo_phrase/tweet"


module EmoPhrase
class Collector

  attr_accessor :start_row, :end_row, :twitter_cycle_limit

  def initialize
    @db           = EmoPhrase::Database.new
    @xlsx         = EmoPhrase::Xlsx.new
    @twitter_ids         = nil
    @start_row           = 0
    @end_row             = 1048576
    @twitter_cycle_limit = 1
  end

  def db=(file)
    @db.file = file
  end

  def twitter_id_list=(xlsx_file)
    @twitter_ids = do_parse_twitter_id_xlsx(xlsx_file)
  end

  def twitter_access(user_id)
    do_twitter_access(user_id)
  end

  def twitter_access_backward(user_id)
    do_twitter_access(user_id, "backward")
  end

  private  #-----------------------------------------------------# private

  def do_parse_twitter_id_xlsx(xlsx_file)
    hash = {
       'sheet' => 'twitter_id_kabu',
#       'sheet' => 'twitter_id_kabu_test',
        'id'=> 1, 'name' => 2, "remarks" => 3,
        'title_line' => 1
    }

    @xlsx.parse_id(xlsx_file, hash)
  end

  def do_set_twitter_api_parameter(api_params)

    ept = EmoPhrase::Tweet.new

    ept.consumer_key         = api_params['consumer_key']
    ept.consumer_secret      = api_params['consumer_secret']
    ept.access_token         = api_params['access_token']
    ept.access_token_secret  = api_params['access_token_secret']
    ept
  end

  def do_twitter_access(user_id, type = nil)
    api_params = @db.twitter_api_params(user_id)

    ept = do_set_twitter_api_parameter(api_params)
    ept.cycle_limit = @twitter_cycle_limit
    cnt = 0
    @twitter_ids.each do |id|
      cnt += 1
      next if @end_row < cnt || @start_row > cnt
puts id
      type.nil? ? ept.access(id) : ept.access_backward(id)
      result = ept.result_array
      @db.register_twitter(result)
    end
  end



end
end


