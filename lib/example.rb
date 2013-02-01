require "./birdcage"

a = Text.new(['a', 'bb', 'ccc', 'dddd'])
nums = Text.new([1, 22, 333, 4444])
l = Text.new(['abcdefghijklmnopqrstuvwxyz'], {'trim'=>true})
#l = Text.new(['abcdefghijklmnopqrstuvwxyz'])
p = Phrase.new([l, nums])
    
#puts l.lens
#l.select(0)
#puts l.cur_len
#l.select(1)
#puts l.cur_len
#l.select(3)
#l.select_next
#puts 'curtext'
#puts l.cur_text
#puts '' 
#puts l.cur_len
#puts l.next_len

puts p.non_trim_length
puts p.generate({'length'=>40, 'delimiter'=>', '})
