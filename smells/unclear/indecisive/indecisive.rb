# Subject under test
require 'rbconfig'

def join_path(fragments)
  if /mswin/ =~ RbConfig::CONFIG['host_os']
    separator = "\\"
    pattern = /\\+/
  else
    separator = "/"
    pattern = /\/+/
  end
  fragments.join(separator).gsub(pattern, separator)
end

# Test
class Indecisive < SmellTest
  def test_simple_case_on_windows
    RbConfig::CONFIG.stub(:[], "mswin", ["host_os"]) do
      fragments = ["foo", "bar", "baz"]

      assert_equal "foo\\bar\\baz", join_path(fragments)
    end
  end

  def test_simple_case_on_linux
    fragments = ["foo", "bar", "baz"]

    assert_equal "foo/bar/baz", join_path(fragments)
  end

  def test_contains_separators_on_windows
    RbConfig::CONFIG.stub(:[], "mswin", ["host_os"]) do
      fragments = ["\\foo\\", "bar\\biz", "boo", "baz\\"]

      assert_equal "\\foo\\bar\\biz\\boo\\baz\\", join_path(fragments)
    end
  end

  def test_contains_separators_on_linux
    fragments = ["/foo/", "bar/biz", "boo", "baz/"]

    assert_equal "/foo/bar/biz/boo/baz/", join_path(fragments)
  end
end
