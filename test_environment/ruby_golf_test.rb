require "minitest/autorun"
require "ruby_golf"

class RubyGolfTest < Minitest::Test

  def test_hole1
    assert_equal 2, RubyGolf.hole1(1, 1)
    assert_equal 4, RubyGolf.hole1(1, 3)
  end

  def test_hole2
    assert_equal({a: 'A', b: 'B'}, RubyGolf.hole2(%w(a b)))
  end

end
