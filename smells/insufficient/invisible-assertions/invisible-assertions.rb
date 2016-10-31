require "helper"

# Subject under test
def is_21?(person)
  if person.age < 21
    raise "Sorry, adults only!"
  end
end

# Test
class InvisibleAssertions < SmellTest
  def test_is_21
    person = OpenStruct.new(age: 21)

    assert_nothing_raised {  is_21?(person) }

  end

  def test_is_under_age
    person = OpenStruct.new(age: 20)

    error = assert_raises { is_21?(person) }
    assert_equal 'Sorry, adults only!', error.message
  end

  def assert_nothing_raised
    yield
  end
end
