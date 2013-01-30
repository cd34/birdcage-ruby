require "./lib/birdcage"
require "test/unit"

class PhraseTest < Test::Unit::TestCase  

  def test_non_trim_length
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    test_phrase = Phrase.new([text_a, text_b])

    assert_equal(2, test_phrase.non_trim_length)
  end

  def test_phrase_object
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    text_trim = Text.new(['longer message'], {'trim'=>true, 'min_length'=>5})

    assert_equal(Phrase.new([text_a,text_b]).generate(),
        'aa bb')
    assert_equal(Phrase.new([text_a,text_trim]).generate(),
        'aa longer message')
  end

  def test_phrase_delim_object
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    text_trim = Text.new(['longer message'], {'trim'=>true, 'min_length'=>5})
    text_long_trim = Text.new(['this is a much longer message'],
        {'trim'=>true})

    assert_equal(Phrase.new([text_a,text_b]).
      generate(delimiter=', '), 'aa, bb')
    assert_equal(Phrase.new([text_a,text_trim]).
      generate(delimiter=', '), 'aa, longer message')
  end
   
  def test_phrase_length_object
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    text_trim = Text.new(['longer message'], {'trim'=>true, 'min_length'=>5})
    text_long_trim = Text.new(['this is a much longer message'],
        {'trim'=>true})
    assert_equal(Phrase.new([text_a,text_b]).
      generate(length=50), 'aa bb')
    assert_equal(Phrase.new([text_a,text_trim]).
      generate(length=50), 'aa longer message')

    assert_equal(Phrase.new([text_a,text_b]).
      generate(length=10), 'aa bb')
    assert_equal(Phrase.new([text_a, text_trim]).
      generate(length=10), 'a longe...')

    assert_equal(Phrase.new([text_a, text_long_trim]).
      generate(length=50), 'aa this is a much longer message')

    #Phrase.new([text_a,text_b]).generate(length=1)
    #exception = assert_raise(ValueError) {text_object.select_next}
    #assert_equal('Invalid length, phrase generate parameter too small', 
    #  exception.message)
  end

  def test_phrase_example
    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_b = Text.new(['until armageddon strikes the earth'], {'trim'=>true})
    assert_equal(Phrase.new([text_a, text_b]).
      generate(length=40), '1h45m until armageddon strikes the earth')

    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_b = Text.new(['until armageddon strikes the earth'], {'trim'=>true})
    assert_equal(Phrase.new([text_a, text_b]).
      generate(length=30), '1h45m until armageddon stri...')

    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_c = Text.new(['until armageddon strikes the earth'],
      min_length=24, trim=true)
    assert_equal(Phrase.new([text_a, text_c]).
      generate(length=30), '1:45 until armageddon strik...')
  end

end
