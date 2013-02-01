require "./birdcage"

"""
create a Text object with a series of possible strings
"""
a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes', '1h45m', 
          '1:45'])

"""
create a Text object that has an additional phrase to be displayed
after the first Text object. We will set the attribute trim which will allow
this text to be sliced if there isn't enough room.
"""
b = Text.new(['until armageddon strikes the earth'], {'trim'=>true})

"""
Create the phrase from the Text objects
"""
phrase = Phrase.new([a, b])

"""
Generate the phrase
"""
puts 'No maximum set, generate phrase'
puts 'expecting: one hour, fourty-five minutes until armageddon strikes the earth'
puts 'received:  ' + phrase.generate
puts 


"""
Select a different delimiter between the Text objects
"""
puts 'No maximum length set, generate phrase with ": " as the delimiter'
puts 'expecting: one hour, fourty-five minutes: until armageddon strikes the earth'
puts 'received:  ' + phrase.generate({'delimiter'=>': '})
puts

"""
Set a maximum length for the message. Birdcage will try to compact the string
gracefully.
"""
puts 'Set a maximum length of 40 characters'
puts 'expecting: 1h45m until armageddon strikes the earth'
puts 'received:  ' + phrase.generate({'length'=>40})
puts

puts 'Set a maximum length of 30 characters'
puts 'expecting: 1h45m until armageddon stri...'
puts 'received:  ' + phrase.generate({'length'=>30})
puts
