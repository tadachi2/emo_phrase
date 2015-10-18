# -*- encoding:utf-8 -*-
#
# EmoPhrase::Tweet
#
#======================================================================

require "twitter"
#require "json"

module EmoPhrase
class Tweet

  attr_accessor :id, :consumer_key, :consumer_secret,
                :access_token, :access_token_secret, :count_limit
  
  TWEETS_NUM  = 200
  SLEEP_SEC   = 8
  SESSION_REG = 8

  def initialize
    @client       = nil
    @url          = "" 
    @tweets       = []
    @count_limit  = 2  # max 16
    @session_reg  = 0
    @user_count   = 0
  end

  def access(id)
    do_setup_config if @client.nil?

    do_access(id) if id && @client
  end

  def access_backward(id)
    do_setup_config if @client.nil?

    do_access_backward(id) if id && @client
  end

  def search_keyword(keyword)
    do_setup_config if @client.nil?

    do_search(keyword) if keyword && @client
  end

  def result_array
    do_parse_json
  end

  private #------------------------------------------------------# private

  def do_setup_config
    if @consumer_key && @consumer_secret && 
       @access_token && @access_token_secret

      config = {
        :consumer_key         => @consumer_key,
        :consumer_secret      => @consumer_secret,
        :access_token         => @access_token,
        :access_token_secret  => @access_tiken_secret
      }

      @client = Twitter::REST::Client.new(config)
    end
  end

  def do_access(id)

    tweet_ary = @client.user_timeline(id, { count: TWEETS_NUM })
    @tweets.push tweet_ary
    sleep SLEEP_SEC
  end

  def do_access_backward(id)
    return if @client.nil?

    if @session_reg % SESSION_REG == 0 
      @client = do_setup_config
    end

    max_id = 0
    @count_limit.times do |c|
puts c
      if max_id == 0
        tweet_ary = @client.user_timeline(id, { count: TWEETS_NUM })
        max_id = tweet_ary[-1].id - 1
      else
        tweet_ary = @client.user_timeline(id, { count: TWEETS_NUM, max_id: max_id })
      end
      @tweets.push tweet_ary
      break if tweet_ary.length == 0
      max_id = tweet_ary[-1].id - 1
     
      sleep SLEEP_SEC
    end
    @session_reg += 1
  end

  def do_search(keyword)
    tweet_ary = @client.search(id, { count: 100 })

  end


  def do_parse_json
    ary = {}

    @tweets.each do |tary|
      tary.each do |t|
        hash = {
          'created_at'  => t.created_at,
          'tweet_id'    => t.id,
          'user_id'     => t.user.id,
          'screen_name' => t.user.screen_name,
          'user_name'   => t.user.name,
          'text'        => t.text
        }
        ary[ t.id ] =  hash
      end
    end
    @tweets = []
    ary.values
  end

end
end

