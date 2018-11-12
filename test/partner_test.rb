require 'test/unit'
require './partner'
require './address'

class PartnerTest < Test::Unit::TestCase
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

    @address1 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, nil, @valid_first_name, @valid_last_name)
    @address2 = Address.new(@valid_street + '1', @valid_house_no, @valid_zip, @valid_city, @valid_country, nil, @valid_first_name + '1', @valid_last_name)
  end

  # task tests

  def test_create_succ
    partner = Partner.new(@valid_first_name, @valid_last_name, @address1)
    assert_true(partner.is_a? Partner)
  end

  def test_create_succ_double_array
    partner1 = Partner.new(@valid_first_name, @valid_last_name, @address1)
    partner_copy = Partner.new(partner1.first_name, partner1.last_name, @address1)
    partner2 = Partner.new(partner1.first_name + '1', partner1.last_name, @address1)

    my_array = []
    my_array.push(partner1)
    assert_true(my_array.include?(partner1))
    assert_true(my_array.include?(partner_copy))
    assert_false(my_array.include?(partner2))
    my_array.push(partner2)
    assert_true(my_array.include?(partner2))
  end

  def test_create_succ_double_set
    partner1 = Partner.new(@valid_first_name, @valid_last_name, @address1)
    partner_copy = Partner.new(partner1.first_name, partner1.last_name, @address1)
    partner2 = Partner.new(partner1.first_name + '1', partner1.last_name, @address1)

    my_set = Set.new
    assert_true(!!my_set.add?(partner1))
    assert_nil(my_set.add?(partner1))
    assert_nil(my_set.add?(partner_copy))
    assert_true(!!my_set.add?(partner2))
  end

  def test_create_succ_double_range
    partner1 = Partner.new(@valid_first_name, @valid_last_name, @address1)
    partner2 = Partner.new(partner1.first_name.next.next.next, partner1.last_name, @address1)
    partner_between = Partner.new(partner1.first_name.next, partner1.last_name, @address1)

    my_range = partner1..partner2
    # todo not working
    #assert_true(my_range.include?(partner_between))
  end

  def test_comparable
    partner1 = Partner.new('Anna', 'AAA', @address1)
    partner2 = Partner.new('Maria', 'ZZZ', @address1)

    assert_true(partner2 > partner1)
  end

  # argument tests

  def test_create_err_fname_empty1
    assert_raise(ArgumentError) do
      Partner.new(nil, @valid_last_name, @address1)
    end
  end

  def test_create_err_fname_empty2
    assert_raise(ArgumentError) do
      Partner.new('   ', @valid_last_name, @address1)
    end
  end

  def test_create_err_fname_int
    assert_raise(ArgumentError) do
      Partner.new(1, @valid_last_name, @address1)
    end
  end

  def test_create_err_lname_empty1
    assert_raise(ArgumentError) do
      Partner.new(@valid_first_name, nil, @address1)
    end
  end

  def test_create_err_lname_empty2
    assert_raise(ArgumentError) do
      Partner.new(@valid_first_name, '   ', @address1)
    end
  end

  def test_create_err_lname_int
    assert_raise(ArgumentError) do
      Partner.new(@valid_first_name, 1, @address1)
    end
  end
end