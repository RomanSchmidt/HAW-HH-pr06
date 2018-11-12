require 'test/unit'
require './pow3'

class Pow3Test < Test::Unit::TestCase

  # tests tasks
  def test_range
    my_range = Pow3.new(4)..Pow3.new(6)
    assert_includes(my_range, Pow3.new(5))
  end

  # tests params
  def test_err_exp_empty
    assert_raise(ArgumentError) do
      Pow3.new(nil)
    end
  end

  def test_err_exp_string
    assert_raise(ArgumentError) do
      Pow3.new('asdf')
    end
  end

  def test_err_exp_float
    assert_raise(ArgumentError) do
      Pow3.new(1.1)
    end
  end
end