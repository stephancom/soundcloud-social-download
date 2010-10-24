require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :email => 'example@example.com' }
    end

    assert session[:download]
    assert_redirected_to root_path
  end
end
