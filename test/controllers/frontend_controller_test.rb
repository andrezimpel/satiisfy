require 'test_helper'

class FrontendControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get questions" do
    get :questions
    assert_response :success
  end

  test "should get question" do
    get :question
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
