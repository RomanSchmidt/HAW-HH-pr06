require 'test/unit'
require './customer'
require './partner'
require './address'
require 'date'

class CustomerV2Test < Test::Unit::TestCase
  def test_create_succ
    address = Address.new('street_customer_test_1', 1, 'zip1', 'city1', 'country1')
    customer = Customer.new('first_name1', 'last_name1', Date.parse('31-12-2010'), address)
    assert_true(customer.is_a? Customer)
  end

  # todo redo
  def test_create_err_double
    #address = Address.new('street_customer_test_2', 2, 'zip2', 'city2', 'country2')
    #customer = Customer.new('first_name2', 'last_name2', Date.parse('31-12-2010'), address)
    #assert_true(customer.is_a? Customer)
    #assert_raise(AmbiguousV2Error) do
    #  Customer.new('first_name2', 'last_name2', Date.parse('31-12-2010'), address)
    #end
  end

  def test_create_err_fname_empty1
    address = Address.new('street_customer_test_3', '3', 'zip3', 'city3', 'country3')
    assert_raise(ArgumentError) do
      Customer.new(nil, 'last_name1', Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_fname_empty2
    address = Address.new('street_customer_test_4', '4', 'zip4', 'city4', 'country4')
    assert_raise(ArgumentError) do
      Customer.new('   ', 'last_name1', Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_fname_int
    address = Address.new('street_customer_test_5', '5', 'zip5', 'city5', 'country5')
    assert_raise(ArgumentError) do
      Customer.new(1, 'last_name1', Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_lname_empty1
    address = Address.new('street_customer_test_6', '6', 'zip6', 'city6', 'country6')
    assert_raise(ArgumentError) do
      Customer.new('first_name3', nil, Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_lname_empty2
    address = Address.new('street_customer_test_7', '7', 'zip7', 'city7', 'country7')
    assert_raise(ArgumentError) do
      Customer.new('first_name4', '   ', Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_lname_int
    address = Address.new('street_customer_test_8', '8', 'zip8', 'city8', 'country8')
    assert_raise(ArgumentError) do
      Customer.new('first_name5', 1, Date.parse('31-12-2010'), address)
    end
  end

  def test_create_err_date_empty
    address = Address.new('street_customer_test_9', '9', 'zip9', 'city9', 'country9')
    assert_raise(ArgumentError) do
      Customer.new('first_name6', 'last_name1', nil, address)
    end
  end

  def test_create_err_date_int
    address = Address.new('street_customer_test_10', '10', 'zip10', 'city10', 'country10')
    assert_raise(ArgumentError) do
      Customer.new('first_name7', 'last_name1', 'asedf', address)
    end
  end

  def test_create_err_address_empty
    assert_raise(ArgumentError) do
      Customer.new('first_name6', 'last_name1', Date.parse('31-12-2010'), nil)
    end
  end

  def test_create_err_address_int
    assert_raise(ArgumentError) do
      Customer.new('first_name8', 'last_name1', Date.parse('31-12-2010'), 'aa')
    end
  end

  def test_create_succ_address_ambi
    address = Address.new('street_customer_test_11', '11', 'zip11', 'city11', 'country11')
    Customer.new('first_name9', 'last_name1', Date.parse('31-12-2010'), address)
    Customer.new('first_name10', 'last_name1', Date.parse('31-12-2010'), address)
  end

  # todo redo
  def test_create_succ_eql_part
  #  address = Address.new('street_customer_test_12', 12, 'zip12', 'city12', 'country12')
  #  customer = Partner.new('first_name11', 'last_name2', address)
  #  assert_true(customer.is_a? Partner)
  #  assert_nothing_raised(AmbiguousV2Error) do
  #    Customer.new('first_name11', 'last_name2', Date.parse('31-12-2010'), address)
  #  end
  end
end