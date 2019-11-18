require 'test_helper'

class InscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get inscriptions_create_url
    assert_response :success
  end

end
