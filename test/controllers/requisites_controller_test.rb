require 'test_helper'

class RequisitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requisites_index_url
    assert_response :success
  end

end
