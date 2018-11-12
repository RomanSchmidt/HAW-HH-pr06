require 'test/unit'
require './address'
require './partner'

class AddressTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @partner = Partner.new('first_name', 'last_name', nil, 'street1', '1', 'zip1', 'city', 'country')
  end

  def test_create_succ
    address = Address.new('street1', '1', 'zip1', 'city1', 'country1', @partner)
    assert_true(address.is_a? Address)
  end

  # todo redo
  def test_create_err_double
    #address = Address.new('street2', '1', 'zip2', 'city2', 'country2', @partner)
    #assert_true(address.is_a? Address)
    #assert_raise(AmbiguousV2Error) do
    #  Address.new('street2', '1', 'zip2', 'city2', 'country2', @partner)
    #end
  end

  def test_create_err_street_empty1
    assert_raise(ArgumentError) do
      Address.new(nil, '1', 'zip1', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_street_empty2
    assert_raise(ArgumentError) do
      Address.new('    ', '1', 'zip1', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_street_int
    assert_raise(ArgumentError) do
      Address.new(1, '1', 'zip1', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_house_empty1
    assert_raise(ArgumentError) do
      Address.new('street3', nil, 'zip1', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_house_str
    assert_raise(ArgumentError) do
      Address.new('street5', 1, 'zip1', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_zip_empty1
    assert_raise(ArgumentError) do
      Address.new('street6', '1', nil, 'city1', 'country1', @partner)
    end
  end

  def test_create_err_zip_empty2
    assert_raise(ArgumentError) do
      Address.new('street7', '1', '   ', 'city1', 'country1', @partner)
    end
  end

  def test_create_err_zip_int
    assert_raise(ArgumentError) do
      Address.new('street8', '1', 1, 'city1', 'country1', @partner)
    end
  end

  def test_create_err_city_empty1
    assert_raise(ArgumentError) do
      Address.new('street9', '1', 'zip1', nil, 'country1', @partner)
    end
  end

  def test_create_err_city_empty2
    assert_raise(ArgumentError) do
      Address.new('street10', '1', 'zip1', '   ', 'country1', @partner)
    end
  end


  def test_create_err_city_int
    assert_raise(ArgumentError) do
      Address.new('street11', '1', 'zip1', 1, 'country1', @partner)
    end
  end

  def test_create_err_country_empty1
    assert_raise(ArgumentError) do
      Address.new('street12', '1', 'zip1', 'city1', nil, @partner)
    end
  end

  def test_create_err_country_empty2
    assert_raise(ArgumentError) do
      Address.new('street13', '1', 'zip1', 'city1', '      ', @partner)
    end
  end

  def test_create_err_country_int
    assert_raise(ArgumentError) do
      Address.new('street14', '1', 'zip1', 'city1', 1, @partner)
    end
  end

  def test_succ_each
    address = Address.new('street_test_each_1', '1', 'zip', 'city', 'country', @partner)
    found = 0
    address.each_partner do |partner|
      found += 1
    end
    assert_equal(1, found)
    partner = []
    partner << Partner.new('first_name_test_each1', 'last_name', address)
    found = 0
    address.each_partner do |partner_of_each|
      if found == 0
        assert_true(partner_of_each == @partner)
      else
        assert_true(partner_of_each == partner[0])
      end
      found += 1
    end
    assert_equal(1, found)

    partner << Partner.new('first_name_test_each2', 'last_name', address)
    found = 0
    address.each_partner do |partner_of_each|
      if found == 0
        assert_true(partner_of_each == @partner)
      else
        assert_true(partner_of_each == partner[found +1])
      end
      found += 1
    end
    assert_equal(1, found)
  end
end