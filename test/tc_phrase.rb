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

    assert_equal('aa bb', Phrase.new([text_a,text_b]).generate())
    assert_equal('aa longer message', 
      Phrase.new([text_a,text_trim]).generate())
  end

  def test_phrase_delim_object
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    text_trim = Text.new(['longer message'], {'trim'=>true, 'min_length'=>5})
    text_long_trim = Text.new(['this is a much longer message'],
        {'trim'=>true})

    assert_equal('aa, bb', Phrase.new([text_a,text_b]).
      generate({'delimiter'=>', '}))
    assert_equal('aa, longer message', Phrase.new([text_a,text_trim]).
      generate({'delimiter'=>', '}))
  end
   
  def test_phrase_length_object
    text_a = Text.new(['a', 'aa'])
    text_b = Text.new(['b', 'bb'])
    text_trim = Text.new(['longer message'], {'trim'=>true, 'min_length'=>5})
    text_long_trim = Text.new(['this is a much longer message'],
        {'trim'=>true})
    assert_equal('aa bb', Phrase.new([text_a,text_b]).
      generate({'length'=>50}))
    assert_equal('aa longer message', Phrase.new([text_a,text_trim]).
      generate({'length'=>50}))

    assert_equal('aa bb', Phrase.new([text_a,text_b]).
      generate({'length'=>10}))
    assert_equal('a longe...', Phrase.new([text_a, text_trim]).
      generate({'length'=>10}))

    assert_equal('aa this is a much longer message', 
      Phrase.new([text_a, text_long_trim]).generate({'length'=>50}))

    exception = assert_raise(ArgumentError) {
      Phrase.new([text_a,text_b]).generate({'length'=>1})
    }
    assert_equal('resulting phrase too short', exception.message)
  end

  def test_phrase_example
    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_b = Text.new(['until armageddon strikes the earth'], {'trim'=>true})
    assert_equal('1h45m until armageddon strikes the earth',
      Phrase.new([text_a, text_b]).generate({'length'=>40}))

    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_b = Text.new(['until armageddon strikes the earth'], {'trim'=>true})
    assert_equal('1h45m until armageddon stri...', Phrase.new([text_a, text_b]).
      generate({'length'=>30}))

    text_a = Text.new(['one hour, fourty-five minutes', '1 hour, 45 minutes',
      '1h45m', '1:45'])
    text_c = Text.new(['until armageddon strikes the earth'],
      {'min_length'=>24, 'trim'=>true})
    assert_equal('1:45 until armageddon strik...', Phrase.new([text_a, text_c]).
      generate({'length'=>30}))
  end

end
