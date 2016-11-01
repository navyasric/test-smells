# Subject under test
def to_arabic(roman)
  roman_to_arabic = {
    "I" => 1,
    "V" => 5,
    "X" => 10
  }

  roman.chars.each_with_index.map { |x, i|
    next_x = roman[i + 1]

    if roman_to_arabic[next_x].nil?
      roman_to_arabic[x]
    else
      if roman_to_arabic[x] >= roman_to_arabic[next_x]
        roman_to_arabic[x]
      else
        -roman_to_arabic[x]
      end
    end
  }.reduce(:+)
end

# Test
class Generative < SmellTest
  EXAMPLES = {
    "I" => 1,
    "II" => 2,
    "III" => 3,
    "IV" => 4,
    "V" => 5,
    "VI" => 6,
    "VII" => 7,
    "VIII" => 8,
    "IX" => 9,
    "X" => 10
  }.each do |(roman, arabic)|
    define_method "test_roman_#{roman}_is_#{arabic}" do
      result = to_arabic(roman)

      assert_equal result, arabic
    end
  end

end
