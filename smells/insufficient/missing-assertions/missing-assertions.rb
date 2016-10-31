require "helper"
require "timecop"

# Subject under test
def fetch(id)
  item = find(id)
end

def update_last_accessed_at(item)
  item.last_accessed_at = Time.new
  item
end

# Test
class MissingAssertions < SmellTest
  def test_gets_the_item
    result = fetch(42)

    assert_equal "Fred", result.name
  end

  def test_sets_last_accessed_at
    t = Time.new(2016, 10, 27)
    Timecop.freeze(t) do
      result = update_last_accessed_at(OpenStruct.new(last_accessed_at: nil))
      assert_equal t, result.last_accessed_at
    end
  end
end

# Fake production implementations to simplify example test of subject
def find(id)
  if id == 42
    OpenStruct.new(name: "Fred", last_accessed_at: nil)
  end
end
