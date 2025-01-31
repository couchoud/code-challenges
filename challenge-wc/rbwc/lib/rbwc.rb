class RBWC

  def self.process(content, options = [:l, :w, :c])
    result = []
    options.each do |option|
      result << parse_option(content, option)
    end
    result.join(' ')
  end

  def self.parse_option(content, option)
    case option
    when :c
      count_bytes(content)
    when :l
      count_lines(content)
    when :w
      count_words(content)
    when :m
      count_chars(content)
    end
  end

  def self.count_bytes(content)
    content.bytesize
  end
  
  def self.count_lines(content)
    content.lines.count
  end

  def self.count_words(content)
    content.split.size
  end

  def self.count_chars(content)
    content.size
  end

end