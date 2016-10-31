# Subject under test
def pricing_for_code(code)
  code.codepoints.first * ((1000 - (code.length * 39.0)) / 42).round
end

# Test
require_relative "../../../support/ruby/generate_code"

class Chafing < SmellTest
  def test_code_one_is_correct
    code = '784'

    result = pricing_for_code(code)

    assert_equal 1155, result
  end

  def test_code_two_is_correct
    code = '(8xj)'

    result = pricing_for_code(code)

    assert_equal 760, result
  end

  def test_code_three_is_correct
    code = 'AAAABCDE'

    result = pricing_for_code(code)

    assert_equal 1040, result
  end
end
