require 'test/unit'
require './customer'
require './partner'
require './address'
require 'date'

class CustomerTest < Test::Unit::TestCase
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
    @valid_date = Date.parse('31-12-2010')

    @address1 = Address.new(@valid_street, @valid_house_no, @valid_zip, @valid_city, @valid_country, nil, @valid_first_name, @valid_last_name)
    @address2 = Address.new(@valid_street + '1', @valid_house_no, @valid_zip, @valid_city, @valid_country, nil, @valid_first_name + '1', @valid_last_name)
  end

  # task tests

  def test_create_succ
    customer = Customer.new(@valid_first_name, @valid_last_name, @valid_date, @address1)
    assert_true(customer.is_a? Customer)
  end

  def test_create_succ_double_set
    my_set = Set.new
    customer1 = Customer.new(@valid_first_name, @valid_last_name, @valid_date, @address1)
    customer2 = Customer.new(@valid_first_name + '1', @valid_last_name, @valid_date, @address1)
    assert_true(!!my_set.add?(customer1))
    assert_nil(my_set.add?(customer1))
    assert_true(!!my_set.add?(customer2))
  end

  def test_create_succ_double_array
    customer1 = Customer.new(@valid_first_name, @valid_last_name, @valid_date, @address1)
    customer_copy = Customer.new(@valid_first_name, @valid_last_name, @valid_date, @address1)
    customer2 = Customer.new(@valid_first_name + '1', @valid_last_name, @valid_date, @address1)

    my_array = []
    my_array.push(customer1)
    assert_true(my_array.include?(customer1))
    assert_true(my_array.include?(customer_copy))
    assert_false(my_array.include?(customer2))
  end

  # argument tests

  def test_create_err_fname_empty1
    assert_raise(ArgumentError) do
      Customer.new(nil, @valid_last_name, @valid_date, @address1)
    end
  end

  def test_create_err_fname_empty2
    assert_raise(ArgumentError) do
      Customer.new('   ', @valid_last_name, @valid_date, @address1)
    end
  end

  def test_create_err_fname_int
    assert_raise(ArgumentError) do
      Customer.new(1, @valid_last_name, @valid_date, @address1)
    end
  end

  def test_create_err_lname_empty1
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, nil, @valid_date, @address1)
    end
  end

  def test_create_err_lname_empty2
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, '   ', @valid_date, @address1)
    end
  end

  def test_create_err_lname_int
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, 1, @valid_date, @address1)
    end
  end

  def test_create_err_date_empty
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, @valid_last_name, nil, @address1)
    end
  end

  def test_create_err_date_int
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, @valid_last_name, 'asedf', @address1)
    end
  end

  def test_create_err_address_empty
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, @valid_last_name, @valid_date, nil)
    end
  end

  def test_create_err_address_int
    assert_raise(ArgumentError) do
      Customer.new(@valid_first_name, @valid_last_name, @valid_date, 'aa')
    end
  end
end