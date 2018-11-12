# Author: Roman Schmidt, Daniel Osterholz
#
# includes Comparable
# Has succ, <=> and eql? to be comparable
# Has to_s to return the value as string
# Has to_i to return the value as int (clone)
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

  def to_i
    @value.clone
  end

  def eql?(other)
    return false unless other.is_a? Pow3
    other.exp === @exp
  end

  alias_method(:==, :eql?)
end