# Subject under test

def increment_age(people)
  people.map { |person|
    person = person.dup
    if person.age.kind_of?(Fixnum)
      person.age += 1
    end
    if person.kids.kind_of?(Array)
      person.kids = increment_age(person.kids)
    end
    person
  }.shuffle
end

# Test
class ComplexAssertions < SmellTest
  #ATTEMPT 1:
  # def test_increments_single_person_age
  #   people = [
  #     OpenStruct.new(name: "Jane", age: 39),
  #     OpenStruct.new(name: "John", age: 99)
  #   ]
  #
  #   results = increment_age(people)
  #
  #   assert_incremented_ages(people, results)
  # end
  #
  # def test_increment_kids_age_too
  #   people = [
  #     OpenStruct.new(
  #       name: "Joe",
  #       age: 42,
  #       kids: [
  #         OpenStruct.new(name: "Jack", age: 8),
  #         OpenStruct.new(name: "Jill", age: 7)
  #       ]
  #     )
  #   ]
  #
  #   results = increment_age(people)
  #
  #   assert_incremented_ages(people, results)
  # end
  #
  # def assert_incremented_ages(people, results)
  #   people.each do |p|
  #     result = results.find { |r| r.name == p.name }
  #     if p.kids.kind_of?(Array)
  #       assert_incremented_ages(p.kids, result.kids)
  #     end
  #     assert_equal p.age + 1, result.age
  #   end
  # end

  #ATTEMPT 2:
  def test_increment_age__increments_all_people_ages
    people = [
      OpenStruct.new(name: 'Jane', age: 30),
      OpenStruct.new(
        name: 'Joe',
        age: 35,
        kids: [
          OpenStruct.new(name: 'Stacy', age: 10),
          OpenStruct.new(name: 'Kyle', age: 9)
        ]
      )
    ]

    expected_results = [
      OpenStruct.new(name: 'Jane', age: 31),
      OpenStruct.new(
        name: 'Joe',
        age: 36,
        kids: [
          OpenStruct.new(name: 'Stacy', age: 11),
          OpenStruct.new(name: 'Kyle', age: 10)
        ]
      )
    ]
    results = increment_age(people)

    assert_ages(expected_results, results)
  end

  def assert_ages(expected, actual)
    expected.each do |e|
      person = actual.find{|a| e.name == a.name }
      assert_equal(e.age, person.age)
      if(e.kids && person.kids)
        assert_ages(e.kids, person.kids)
      end
    end
  end
end
