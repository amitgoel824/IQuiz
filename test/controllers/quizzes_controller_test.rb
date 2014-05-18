require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase
  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get questions" do
    get :questions
    assert_response :success
  end

end
