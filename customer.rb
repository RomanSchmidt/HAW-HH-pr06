require 'set'
require './partner'
require 'date'

# Author: Roman Schmidt, Daniel Osterholz
#
# Has a hash method to be comparable in hash.
# Has a eql? method which is defined as an synonym for == to make objects comparable.
class Customer < Partner

  def initialize(first_name, last_name, birthday, address)
    raise(ArgumentError, 'birthday is not instance of Date') unless birthday.is_a? Date

    @birthday = birthday
    @valet_sum = 0
    super(first_name, last_name, address)
  end

  public

  attr_reader(:birthday)

  def eql?(other)
    return nil unless other.is_a? Customer
    super(other) && other.birthday == @birthday
  end

  alias_method(:==, :eql?)

  def hash
    super.hash * (31 + (@birthday.nil? ? 0 : @birthday.hash))
  end
end