require './address'
require 'set'

# Author: Roman Schmidt, Daniel Osterholz
#
# Has a hash method to be comparable in hash.
# Has a eql? method which is defined as an synonym for == to make objects comparable.
# Has a space ship operator to be comparable
# Has a succ method to be range compatible
class Partner
  include Comparable

  def initialize(first_name, last_name, address = nil, street = nil, house_no = nil, zip = nil, city = nil, country = nil)
    raise(ArgumentError, 'first_name is not a string') unless first_name.is_a? String
    first_name_cleaned = first_name.strip
    raise(ArgumentError, 'first_name is empty') if first_name_cleaned.length == 0

    raise(ArgumentError, 'last_name is not a string') unless last_name.is_a? String
    last_name_cleaned = last_name.strip
    raise(ArgumentError, 'last_name is empty') if last_name_cleaned.length == 0

    if false == (address.is_a? Address) && address.nil? == false
      raise(ArgumentError, 'address is not nil nor instance of Address')
    end

    @first_name = first_name_cleaned
    @last_name = last_name_cleaned

    @address = address.nil? ? Address.new(street, house_no, zip, city, country, self) : address
  end

  public

  attr_reader(:first_name, :last_name, :address)

  def <=>(other)
    return nil unless other.is_a? Partner
    first_level = @last_name <=> other.last_name
    return first_level if first_level == 1 || first_level == -1

    puts 'space shit'
    puts @first_name
    puts other.first_name
    puts first_level
    @first_name <=> other.first_name
  end

  def succ
    Partner.new(@first_name, @last_name.next, @address)
  end

  def eql?(other)
    return nil unless other.is_a? Partner
    other.first_name == @first_name && other.last_name == @last_name
  end

  alias_method(:==, :eql?)

  def set_address(address)
    raise(ArgumentError, 'address is not instance of Address') unless address.is_a? Address
    raise(ArgumentError, 'new Address does not include this customer') unless address.include_partner?(self)
    @address = address
    self
  end

  def hash
    prime = 31
    (prime + (@first_name.nil? ? 0 : @first_name.hash)) *
        (prime + (@last_name.nil? ? 0 : @last_name.hash))
  end

  def to_s
    {first_name: @first_name, last_name: @last_name, address: @address.to_s}.to_s
  end
end