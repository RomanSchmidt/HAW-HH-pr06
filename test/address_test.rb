require 'test/unit'
require './address'
require './partner'

class AddressTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @valid_street = 'street'
    @valid_country = 'country'
    @valid_city = 'city'
    @valid_zip = 'zip'
    @valid_house_no = 'two'
    @valid_last_name = 'lastName'
    @valid_first_name = 'firstName'

    @partner1 = Partner.new(@valid_first_name, @valid_last_name, nil, @valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country)
    @partner2 = Partner.new(@valid_first_name + '1', @valid_last_name, nil, @valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country)
    @partner3 = Partner.new(@valid_first_name + '2', @valid_last_name, nil, @valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country)
  end

  def test_create_succ
    address = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    assert_true(address.is_a? Address)
  end

  # tests to show the tasks

  def test_create_err_double_array
    address1 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    assert_true(address1.is_a? Address)
    address2 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner2)
    assert_true(address2.is_a? Address)

    addresses = [address1]
    assert_true(addresses.include?(address2))
  end

  def test_create_err_double_set
    address1 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    assert_true(address1.is_a? Address)
    address2 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner2)
    assert_true(address2.is_a? Address)

    addresses = Set.new
    assert_true(!!addresses.add?(address1))
    assert_true(addresses.include?(address2))
    assert_nil(addresses.add?(address2))
  end

  def test_succ_each
    address = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    found = 0
    address.each_partner do |partner|
      found += 1
    end
    assert_equal(1, found)
    partner = []
    partner << Partner.new(@valid_first_name, @valid_last_name, address)
    found = 0
    address.each_partner do |partner_of_each|
      if found == 0
        assert_true(partner_of_each == @partner1)
      else
        assert_true(partner_of_each == partner[0])
      end
      found += 1
    end
    assert_equal(1, found)

    partner << Partner.new(@valid_first_name, @valid_last_name, address)
    found = 0
    address.each_partner do |partner_of_each|
      if found == 0
        assert_true(partner_of_each == @partner1)
      else
        assert_true(partner_of_each == partner[found +1])
      end
      found += 1
    end
    assert_equal(1, found)
  end

  def test_succ_range
    address_start = Address.new(@valid_street, @valid_house_no, '4', @valid_city, @valid_country, nil, @partner1.first_name, @partner1.last_name)
    address_between = Address.new(@valid_street, @valid_house_no, '7', @valid_city, @valid_country, nil, @partner1.first_name, @partner1.last_name)
    address_end = Address.new(@valid_street, @valid_house_no, '10', @valid_city, @valid_country, nil, @partner1.first_name, @partner1.last_name)
    my_range = address_start..address_end

      # todo not working
      #assert_true(my_range.include?(address_between))
  end

  # error tests of params

  def test_create_err_street_empty1
    assert_raise(ArgumentError) do
      Address.new(nil, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_street_empty2
    assert_raise(ArgumentError) do
      Address.new('    ', @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_street_int
    assert_raise(ArgumentError) do
      Address.new(1, @valid_house_no, @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_house_empty1
    assert_raise(ArgumentError) do
      Address.new(@valid_street, nil, @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_house_empty2
    assert_raise(ArgumentError) do
      Address.new(@valid_street, '   ', @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_house_int
    assert_raise(ArgumentError) do
      Address.new(@valid_street, 1, @valid_zip, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_zip_empty1
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, nil, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_zip_empty2
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, '   ', @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_zip_int
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, 1, @valid_city, @valid_country, @partner1)
    end
  end

  def test_create_err_city_empty1
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, nil, @valid_country, @partner1)
    end
  end

  def test_create_err_city_empty2
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, '   ', @valid_country, @partner1)
    end
  end


  def test_create_err_city_int
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, 1, @valid_country, @partner1)
    end
  end

  def test_create_err_country_empty1
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, nil, @partner1)
    end
  end

  def test_create_err_country_empty2
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, '      ', @partner1)
    end
  end

  def test_create_err_country_int
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, 1, @partner1)
    end
  end

  def test_create_err_partner_string
    assert_raise(ArgumentError) do
      Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, 'asdf')
    end
  end
end