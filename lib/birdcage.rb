# frozen_string_literal: true

class Text
  attr_accessor :trim, :selected, :maxlen, :min_length

  def initialize(args, trim: false, trim_delim: "...", min_length: 10)
    @args = args.map(&:to_s).sort_by(&:length)
    @trim = trim
    @trim_delim = trim_delim
    @min_length = min_length
    @min_length += @trim_delim.length if @trim
    @maxlen = @args.max_by(&:length)
    @selected = 0
  end

  def lens
    @args.map(&:length)
  end

  def select(selected)
    if selected < @args.length && selected >= 0
      @selected = selected
    else
      raise IndexError, "Index out of range"
    end
  end

  def cur_text(trim_length: nil)
    if trim_length && @trim && trim_length < @args[@selected].length
      trimmed_length = trim_length - 3
      "#{@args[@selected][0...trimmed_length]}..."
    else
      @args[@selected]
    end
  end

  def cur_len
    @args[@selected].length
  end

  def next_len
    if @selected < @args.length - 1
      @args[@selected + 1].length
    end
  end

  def select_next
    if @selected < @args.length - 1
      @selected += 1
    else
      raise IndexError, "Index out of range"
    end
  end
end

class Phrase
  def initialize(args)
    @args = args
  end

  def generate(delimiter: " ", length: nil)
    max_message = @args.map(&:maxlen).join(delimiter)
    return max_message if !length || max_message.length <= length

    lens = @args.filter_map { |x| x.lens unless x.trim }
    len_trims = @args.filter_map { |x| x.min_length if x.trim }

    max_length = length - delimiter.length * @args.length -
      len_trims.sum

    raise ArgumentError, "resulting phrase too short" if max_length < 0

    current_len = non_trim_length
    num_lens = lens.length
    len_count = 0

    while current_len < max_length && len_count < num_lens
      @args.each do |x|
        next_l = x.next_len
        if next_l && next_l - x.cur_len + current_len < max_length
          x.select_next
          current_len = non_trim_length
          len_count = 0
        else
          len_count += 1
        end
      end
    end

    final_lens = @args.filter_map { |x| x.cur_len unless x.trim }.sum
    trim_length = (length - delimiter.length * @args.length -
      final_lens + 1) / len_trims.length
    @args.map { |x| x.cur_text(trim_length: trim_length) }.join(delimiter)
  end

  def non_trim_length
    length = 0
    @args.each do |x|
      length += x.cur_text.length unless x.trim
    end
    length
  end
end
