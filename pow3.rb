class Pow3
  include Comparable

  def initialize(exp)
    raise(ArgumentError, 'exp is not an integer') unless exp.is_a?(Integer)
    @exp = exp
    @value = exp ** 3
  end

  public

  attr_reader :exp, :value

  def <=>(other)
    @exp <=> other.exp
  end

  def succ
    Pow3.new(@exp + 1)
  end

  def to_s
    @value.to_s
  end
end