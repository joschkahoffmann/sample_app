require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@user= users(:michael)
  end

  test "should get new" do
    get '/signup'
    assert_response :success
  end

  test "should redirect when not logged in" do
  	get edit_user_path(@user),
  	params:{user:{id: @user.id}}
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch user_url(@user),
  	params:{user:{id: @user.id, name: @user.name, email: @user.email}}
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end
end
