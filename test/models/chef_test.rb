require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
  @chef = Chef.new(chefname: 'john', email: 'john@example.com')
end

  test 'chef should be valid' do
    assert @chef.valid?
  end
  
  test 'chefname should be present' do
    @chef.chefname = ' '
    assert_not @chef.valid?
  end
  
  test 'chefname should not be too long' do
  @chef.chefname = 'a' * 41
  assert_not @chef.valid?
    end

 test 'chefname should not be too short' do
   @chef.chefname = 'aa'
   assert_not @chef.valid?
  end
  
  test 'email should be present' do
    @chef.email = ' '
    assert_not @chef.valid?
  end
  
  test 'email length should be within bounds' do
    @chef.email = 'a' * 101 + '@example.com'
    assert_not @chef.valid?
  end
  
  test 'email address should be unique' do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
end
  end
  
  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?,  '#{ia.inspect} should be invalid'
    end
  end
  
end