# -*- encoding:utf-8 -*-
#
# EmoPhrase::Xlsx
#
#=======================================================================

require "rubyXL"

module EmoPhrase
class Xlsx

  def initialize
    @xlsx 
  end

  def parse_id(xlsx_file, hash)
    do_parse('id', xlsx_file, hash)

  end

  private #---------------------------------------------------# private

  def do_parse(type, xlsx_file, hash)
    wb = RubyXL::Parser.parse(xlsx_file)    
    ws = wb[ hash['sheet'] ]
    result = nil

    case type
    when 'id'
      result = do_read_id_from_ws(ws, hash)
    end
    result
  end

  def do_read_id_from_ws(ws, hash)
    id_hash   = {}
    row       = hash['title_line']
    col_id    = hash['id']
    title_flg = true 

    until  ws[row].nil?
      if title_flg
        title_flg = false
        row += 1
        next
      end
      
      id_hash[ ws[row][col_id].value ] = true unless ws[row][col_id].nil?

      row += 1
    end
    id_hash.keys
  end

end
end

