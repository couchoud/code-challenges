require "minitest/autorun"
require "rbwc"

class RBWCTest < Minitest::Test

  def setup
    @content = File.read('test/fixture.txt')
  end

  def test_count_bytes
    assert_equal 87,
      RBWC.count_bytes(@content)
  end

  def test_count_lines
    assert_equal 2,
      RBWC.count_lines(@content)
  end

  def test_count_words
    assert_equal 18,
      RBWC.count_words(@content)
  end

  def test_count_chars
    assert_equal 87,
      RBWC.count_chars(@content)
  end

  def test_parse_option_c
    assert_equal 87,
      RBWC.parse_option(@content, :c)
  end

  def test_parse_option_l
    assert_equal 2,
      RBWC.parse_option(@content, :l)
  end

  def test_parse_option_w
    assert_equal 18,
      RBWC.parse_option(@content, :w)
  end

  def test_parse_option_m
    assert_equal 87,
      RBWC.parse_option(@content, :m)
  end

  def test_parse_options
    assert_equal "2 18 87",
      RBWC.process(@content)
  end

  def test_parse_options
    assert_equal "87 18",
      RBWC.process(@content, [:c, :w])
  end

end