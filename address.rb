require 'set'
require './partner'

# Author: Roman Schmidt, Daniel Osterholz
#
# Includes Unique model.
# Has a hash method to be comparable in hash.
# Has a eql? method which is defined as an synonym for == to make objects comparable.
# Has an each_partner method to to iterate over all partners that have this address.
# Has a space ship operator to be comparable
# Has a succ method to be range compatible
# Has a method to move a company to an other address.
class Address
  include Comparable

  attr_reader(:city, :country, :house_no, :street, :zip)

  def initialize(street, house_no, zip, city, country, partner = nil, partner_first_name = nil, partner_last_name = nil)
    raise(ArgumentError, 'street is not a string') unless street.is_a? String
    street_cleaned = street.strip
    raise(ArgumentError, 'street is empty') if street_cleaned.length == 0

    raise(ArgumentError, 'house_no is not a string') unless house_no.is_a? String
    house_no_cleaned = house_no.strip
    raise(ArgumentError, 'house_no is empty') if house_no_cleaned.length == 0

    raise(ArgumentError, 'zip is not a string') unless zip.is_a? String
    zip_cleaned = zip.strip
    raise(ArgumentError, 'zip is empty') if zip_cleaned.length == 0

    raise(ArgumentError, 'city is not a string') unless city.is_a? String
    city_cleaned = city.strip
    raise(ArgumentError, 'city is empty') if city_cleaned.length == 0

    raise(ArgumentError, 'country is not a string') unless country.is_a? String
    country_cleaned = country.strip
    raise(ArgumentError, 'city is empty') if country_cleaned.length == 0

    if (partner.is_a? Partner) == false && partner.nil? == false
      raise(ArgumentError, 'partner is not nil nor instance of Partner')
    end

    @street = street_cleaned
    @house_no = house_no_cleaned
    @zip = zip_cleaned
    @city = city_cleaned
    @country = country_cleaned

    @partner = partner.nil? ? Partner.new(partner_first_name, partner_last_name, self) : partner
    @registered_partners = []

    if partner.nil? == false && partner.address
      partner.address.move_partner(partner, self)
    end
  end

  public

  def <=>(other)
    return nil unless other.is_a? Address
    @zip <=> other.zip
  end

  def succ
    Address.new(@street, @house_no, @zip.next, @city, @country, @partner)
  end

  def add_partner(partner)
    raise(ArgumentError, 'partner is not instance of Partner') unless partner.is_a? Partner
    @registered_partners.push(partner)
  end

  def hash
    prime = 31
    (prime + (@street.nil? ? 0 : @street.hash)) *
        (prime + (@house_no.nil? ? 0 : @house_no.hash)) *
        (prime + (@zip.nil? ? 0 : @zip.hash)) *
        (prime + (@city.nil? ? 0 : @city.hash)) *
        (prime + (@country.nil? ? 0 : @country.hash))
  end

  def eql?(other)
    return nil unless other.is_a? Address
    (other.street == @street &&
        other.house_no == @house_no &&
        other.zip == @zip &&
        other.city == @city &&
        other.country == @country
    )
  end

  alias_method(:==, :eql?)

  def each_partner(&block)
    @registered_partners.each(&block)
    self
  end

  def move_partner(partner, new_address)
    remove_partner(partner)
    new_address.add_partner(partner)
    partner.set_address(new_address)
    self
  end

  def include_partner?(partner)
    @registered_partners.include?(partner)
  end

  def size_partners
    @registered_partners.size
  end

  private

  def remove_partner(partner)
    # Laut Definition von 1 zu 1* Beziehung wist die folgende if Bedingung notwendig aber in der Praxis eher hinderlich.
    if @registered_partners.size == 1
      raise(ArgumentError, 'Last element of partners can not be removed.')
    end

    @registered_partners.delete(partner)
  end
end