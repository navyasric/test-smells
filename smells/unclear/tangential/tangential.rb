# Subject under test
def set_attr(obj, name, value, type = nil)
  if type
    valid = true

    case type
    when :string
      valid = value.kind_of?(String)
    when :phone
      valid = PhoneValidator.validate(value)
    end

    raise "#{value} is not a #{type}" unless valid
  end

  obj[name] = value
end

class PhoneValidator
  def self.validate(phone)
    north_american = /^\(?([2-9][0-9]{2})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/
    japanese = /^0\d{2}-\d{4}-\d{4}$/
    intl_japanese = /^011-81-\d{2}-\d{4}-\d{4}$/
    phone.match(north_american) ||
    phone.match(japanese) ||
    phone.match(intl_japanese)
  end
end

# Test
class Tangential < SmellTest
  def test_no_type
    user = OpenStruct.new

    set_attr(user, :name, "Fred")

    assert_equal "Fred", user.name
  end

  def test_string_type_correct
    user = OpenStruct.new

    set_attr(user, :name, "Frida", :string)

    assert_equal "Frida", user.name
  end

  def test_string_type_incorrect
    user = OpenStruct.new

    error = assert_raises {
      set_attr(user, :age, 42, :string)
    }
    assert_equal "42 is not a string", error.message
  end

  def test_phone_type_correct
    user = OpenStruct.new
    PhoneValidator.stub(:validate, true, ["(614) 349-4279"]) do
      set_attr(user, :mobile, "(614) 349-4279", :phone)

      assert_equal "(614) 349-4279", user.mobile
    end
  end

  def test_phone_type_incorrect
    user = OpenStruct.new
    PhoneValidator.stub(:validate, false, ["1337"]) do
      error = assert_raises {
        set_attr(user, :mobile, "1337", :phone)
      }
      assert_equal "1337 is not a phone", error.message
    end
  end

  def test_invalid_first_phone_character_cannot_start_with_1
    assert_nil PhoneValidator.validate("(123) 456-7890")
  end

  def test_simple_japanese_phone_number
    assert PhoneValidator.validate("090-1790-1357") != nil
  end

  def test_japanese_without_the_trunk
    assert_nil PhoneValidator.validate("90-1790-1357")
  end

  def test_international_japanese_phone_number
    assert PhoneValidator.validate("011-81-90-1790-1357") != nil
  end
end
