# Subject under test
def rank_hotel_review(user, title, text, stars)
  rank = 10
  rank -= 3 unless user.logged_in
  rank += 10 if stars == 5 || stars == 1
  if rank > 1 && obscene?(title)
    raise "Underage swearing!" unless user.age > 13
    rank = 1
  elsif rank > 3 && obscene?(text)
    rank = 3 unless user.occupation == "sailor"
  end
  return rank
end

# Test
class Quixotic < SmellTest
  def test_3_star_member
    user = OpenStruct.new(logged_in: true)

    result = rank_hotel_review(user, "title", "body", 3)

    assert_equal 10, result
  end

  def test_5_star_member
    user = OpenStruct.new(logged_in: true)

    result = rank_hotel_review(user, "title", "body", 5)

    assert_equal 20, result
  end

  def test_1_star_member
    user = OpenStruct.new(logged_in: true)

    result = rank_hotel_review(user, "title", "body", 1)

    assert_equal 20, result
  end

  def test_3_star_anonymous
    user = OpenStruct.new(logged_in: false)

    result = rank_hotel_review(user, "title", "body", 3)

    assert_equal 7, result
  end

  def test_underage_obscene_title_member
    user = OpenStruct.new(logged_in: true, age: 13)

    error = assert_raises { rank_hotel_review(user, "obscenitiestitle", "body", 3) }
    assert_equal "Underage swearing!", error.message
  end

  def test_right_age_obscene_title_member
    user = OpenStruct.new(logged_in: true, age: 15)
    result = rank_hotel_review(user, "obscenitiestitle", "body", 3)

    assert_equal 1, result
  end

  def test_sailor_obscene_text_member
    user = OpenStruct.new(logged_in: true, age: 15, occupation: 'sailor')
    result = rank_hotel_review(user, "title", "obscenitiesbody", 3)

    assert_equal 10, result
  end

  def test_non_sailor_obscene_text_member
    user = OpenStruct.new(logged_in: true, age: 15, occupation: 'waiter')
    result = rank_hotel_review(user, "title", "obscenitiesbody", 3)

    assert_equal 3, result
  end

end

# Fake production implementations to simplify example test of subject
def obscene?(text)
  text.include?("obscenities")
end
