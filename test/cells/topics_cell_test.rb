require 'test_helper'

class TopicsCellTest < Cell::TestCase
  test "comments" do
    invoke :comments
    assert_select "p"
  end
  

end
