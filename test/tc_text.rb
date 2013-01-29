require "./lib/birdcage"
require "test/unit"

class TextTest < Test::Unit::TestCase  

  def test_create_unicode_text_object
    text_object = Text.new(['111', '22', '3', '555555'])
#        assert_equal(sorted(Text(111,22,3,555555).items), \
#            [u'111', u'22', u'3', u'555555'])
    assert_equal(1, text_object.cur_len)
  end

  def test_create_trim_text_object
    text_object = Text.new(['message'], {'trim'=>true})
#    assert_equal(['message'], @text_object.items)
    assert_equal('message', Text.new(['message'], {'trim'=>true}).cur_text())
    assert_equal(7, Text.new(['message'], 
      {'trim'=>true, 'trim_length'=>10}).cur_len)
    assert_equal(7, Text.new(['message'], {'trim'=>true, 'trim_length'=>5,
      'trim_delim'=>'.'}).cur_len)
  end

  def test_iterate_text_object
    text_object = Text.new(['a','bb','ccc','dddd'])
    assert_equal('a', text_object.cur_text)
    assert_equal(0, text_object.selected)
    assert_equal(1, text_object.cur_len)
    assert_equal(2, text_object.next_len)

    text_object.select_next
    assert_equal('bb', text_object.cur_text)
    assert_equal(1, text_object.selected)
    assert_equal(2, text_object.cur_len)
    assert_equal(3, text_object.next_len)

    text_object.select_next
    assert_equal('ccc', text_object.cur_text)
    assert_equal(2, text_object.selected)
    assert_equal(3, text_object.cur_len)
    assert_equal(4, text_object.next_len)

    text_object.select_next
    assert_equal('dddd', text_object.cur_text)
    assert_equal(3, text_object.selected)
    assert_equal(4, text_object.cur_len)
    assert_equal(nil, text_object.next_len)

    exception = assert_raise(IndexError) {text_object.select_next}
    assert_equal('Index out of range', exception.message)
  end

  def test_select_text_object
    text_object = Text.new(['a','bb','ccc','dddd'])

    text_object.select(0)
    assert_equal(text_object.cur_text(), 'a')

    text_object.select(1)
    assert_equal(text_object.cur_text(), 'bb')

    text_object.select(2)
    assert_equal(text_object.cur_text(), 'ccc')

    text_object.select(3)
    assert_equal(text_object.cur_text(), 'dddd')

    exception = assert_raise(IndexError) {text_object.select(4)}
    assert_equal('Index out of range', exception.message)

    exception = assert_raise(IndexError) {text_object.select(-1)}
    assert_equal('Index out of range', exception.message)
  end

  def test_lens_text_object
    text_object = Text.new(['a','bb','ccc','dddd'])
    assert_equal([1, 2, 3, 4], text_object.lens)

    text_object = Text.new([1, 22, 333, 4444])
    assert_equal([1, 2, 3, 4], text_object.lens)
  end
end


#@l = Text.new(['a', 'bb', 'ccc', 'dddd'])
#@l = Text.new([1, 22, 333, 4444])

#puts @l.lens
#@l.select(0)
#puts @l.cur_len
#@l.select(1)
#puts @l.cur_len
##@l.select(3)
##@l.select_next
#puts 'curtext'
#puts @l.cur_text
#puts ''
#puts @l.cur_len
#puts @l.next_len
