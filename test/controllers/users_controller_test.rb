require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@user= users(:michael)
    @other_user =users(:archer)
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

  test "should redirect index when not logged in" do
    get users_path
    assert_template 'users/index'
    assert_redirect_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path, 
    params:{id: @user.id}
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), 
    params:{user:{id: @user.id, name: @user.name, email: @user.email }}
    assert_redirected_to root_url
  end
end
