class Text
  attr_accessor :trim, :selected

  def initialize args, options = {}
    @args = args.map(&:to_s).sort_by(&:length)
    @trim = options['trim'] || false
    @trim_delim = options['trim_delim'] || '...'
    @min_length = options['min_length'] || 10
    if @trim
      @min_length += @trim_delim.length
    end
    @maxlen = @args.max{ |x, y| x.length <=> y.length}
    @selected = 0
  end

  #def items
  #  return @args
  #end

  def lens
    @args.map { |x| x.length }
  end

  def select selected
    if selected < @args.length and selected >= 0
      @selected = selected
    else
      raise IndexError.new('Index out of range')
    end
  end

  def cur_text(options = {})
    trim_length = options[:trim_length] || nil
    if trim_length and @trim
      append_elipses = ''
      if trim_length < @args[@selected].length
        trim_length -= 3
        append_elipses = '...'
        return self.items[self.selected][:trim_length] + append_elipses
      end
    end
    return @args[@selected]
  end

  def cur_len
    @args[@selected].length
  end

  def next_len
    if @selected < @args.length - 1
       return @args[@selected+1].length
    else
       return nil
    end
  end

  def select_next
    if @selected < @args.length - 1
      @selected += 1
    else
      raise IndexError.new('Index out of range')
    end
  end
end

class Phrase
  def initialize phrase
    @phrase = phrase
  end

  def non_trim_length
    length = 0
    @phrase.each do |x|
      if not x.trim
        length += x.cur_text.length
      end
    end
    return length
  end
end
