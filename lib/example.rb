require "./birdcage"

@l = Text.new(['a', 'bb', 'ccc', 'dddd'])
#@l = Text.new([1, 22, 333, 4444])
    
puts @l.lens
@l.select(0)
puts @l.cur_len
@l.select(1)
puts @l.cur_len
#@l.select(3)
#@l.select_next
puts 'curtext'
puts @l.cur_text
puts '' 
puts @l.cur_len
puts @l.next_len
