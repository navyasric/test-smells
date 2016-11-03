# Subject under test
class Stack
  def initialize
    @items = []
  end

  def push(item)
    @items << item
  end

  def pop
    @items.pop
  end

  def peek
    @items.last
  end

  def depth
    @items.size
  end
end

# Test
class Long < SmellTest
  # def test_make_sure_everything_works
  #   subject = Stack.new
  #
  #   # Test Push
  #   subject.push("A")
  #   subject.push("B")
  #   subject.push("C")
  #
  #   assert_equal "C", subject.pop
  #   assert_equal "B", subject.pop
  #   assert_equal "A", subject.pop
  #
  #   # Test Peek
  #   subject.push("D")
  #   subject.push("E")
  #
  #   assert_equal "E", subject.peek
  #
  #   subject.pop
  #
  #   assert_equal "D", subject.peek
  #
  #   subject.pop
  #
  #   # Test Depth
  #   subject.push("F")
  #   subject.push("G")
  #
  #   assert_equal 2, subject.depth
  #
  #   # Test Pop
  #   subject.pop
  #   subject.pop
  #
  #   assert_equal 0, subject.depth
  #   assert_equal nil, subject.pop
  # end

  def test_push
    subject = Stack.new

    subject.push("A")
    subject.push("B")
    subject.push("C")

    assert_equal "C", subject.pop
    assert_equal "B", subject.pop
    assert_equal "A", subject.pop
  end

  def test_peek
    subject = Stack.new

    subject.push("D")
    subject.push("E")

    assert_equal "E", subject.peek
  end

  def test_peek_empty_stack
    subject = Stack.new
    assert_equal nil, subject.peek
  end

  def test_pop
    subject = Stack.new

    subject.push("D")
    subject.push("E")

    assert_equal 2, subject.depth

    assert_equal "E", subject.pop
    assert_equal "D", subject.pop
    assert_equal 0, subject.depth
  end

  def test_pop_when_empty_stack
    subject = Stack.new
    assert_equal nil, subject.pop
  end

end
