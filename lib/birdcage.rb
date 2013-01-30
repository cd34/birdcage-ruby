class Text
  attr_accessor :trim, :selected, :maxlen, :min_length

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
        return items[selected][:trim_length] + append_elipses
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
  def initialize args
    @args = args
  end

  def generate options
    delim = options['delimiter'] || ' '
    phrase_length = options['length'] || nil
        
    max_message = @args.map {|x| x.maxlen}.join(delim)
    if not phrase_length or max_message.length <= phrase_length
      return max_message
    end

    lens = @args.map {|x| x.lens if not x.trim}.clear
    len_trims = @args.map {|x| x.min_length if x.trim}.clear

    max_length = phrase_length - delim.length * @args.length -
      len_trims.inject(:+)
    puts max_length

    #if max_length < 0
    #  raise ValueError.new('resulting phrase too short')
    #end

    #current_len = non_trim_length(args)
    #num_lens = len(lens)
    #len_count = 0

    #while current_len < max_length and len_count < num_lens:
    #  for x in args:
    #    try:
    #      if x.next_len - x.cur_len + current_len < max_length:
    #        x.select_next()
    #        current_len = non_trim_length(args)
    #        len_count = 0
    #      except:
    #        len_count += 1

#          final_lens = sum([0 if x.trim else x.cur_len for x in args])
#          trim_length = (phrase_length - len(delim) * len(args) -
#            final_lens + 1) / len(len_trims)
#          return delim.join([x.cur_text(trim_length=trim_length)
#            for x in args])
  end

  def non_trim_length
    length = 0
    @args.each do |x|
      if not x.trim
        length += x.cur_text.length
      end
    end
    return length
  end
end
