require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get groups_update_url
    assert_response :success
  end

end
