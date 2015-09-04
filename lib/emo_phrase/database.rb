#
# EmoPhrase::Database
#
#==========================================================================

require "sqlite3"

module EmoPhrase
class Database

  def initialize(db_file = nil)
    @db = do_open_db_file(db_file) if db_file
  end

  def file=(db_file)
    @db = do_open_db_file(db_file)
  end

  def twitter_api_params(id)
    api_params = {}

    sql = "SELECT type, value FROM account_table WHERE media = 'twitter' AND user_id = \'%{user_id}\'\;" % { user_id: id }

    result = @db.execute(sql)

    result.each do |r|
      api_params[r[0]] = r[1] 
    end
    api_params
  end

  def register_twitter(model)
    do_create_tweet_table
    do_register_tweet_table(model) 
  end

  def close
    @db.close
  end

  private #-----------------------------------------------------# private

  def do_open_db_file(db_file)
    db = nil 
    if FileTest.exist? db_file
      db = SQLite3::Database.new(db_file)
    end
    db
  end

  def do_create_tweet_table

    sql = [
          "CREATE TABLE IF NOT EXISTS",
          "tweet_table(",
          "id          INTEGER PRIMARY KEY AUTOINCREMENT,", 
          "created_at  TEXT NOT NULL,", 
          "tweet_id    TEXT NOT NULL,", 
          "user_id     TEXT NOT NULL,", 
          "screen_name TEXT NOT NULL,", 
          "user_name   TEXT NOT NULL,", 
          "text        TEXT NOT NULL", 
          ');',
          "CREATE INDEX IF NOT EXISTS",
          "tweet_id_index",
          'ON tweet_table(tweet_id);'
    ].join(" ")
    @db.execute_batch(sql)


  end

  def do_register_tweet_table(model)

    insert_sql = [
      "INSERT INTO",
      "tweet_table",
      "(created_at, tweet_id, user_id, screen_name, user_name, text)",
      "VALUES (:created_at , :tweet_id, :user_id, :screen_name, :user_name, :text)\;"
    ].join(" ")

puts model.length
    i = 0
    while i < model.length
      select_sql = "SELECT id FROM tweet_table WHERE tweet_id = \'%{tweet_id}\'\;" % { tweet_id: model[i]['tweet_id'] }

      @db.execute(select_sql).length == 0 ? (i += 1) :  model.delete_at(i)
    end
puts model.length

    @db.transaction do
      model.each do |m|

        @db.execute(insert_sql, 
          :created_at  => m['created_at'].to_s, 
          :tweet_id    => m['tweet_id'], 
          :user_id     => m['user_id'],
          :screen_name => m['screen_name'], 
          :user_name   => m['user_name'], 
          :text        => m['text']
        )
      end
    end
  end

 
  def do_create_facebook_table
    sql = [
          "CREATE TABLE IF NOT EXISTS",
          "facebook_table(",
          ")\;"
    ].join(" ")
    @db.execute(sql)
  end

end
end

