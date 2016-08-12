require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  	test 'invalid signup info' do
	  	get signup_path
	  	assert_no_difference 'User.count' do
	  		post users_path,
	  		params:{user: {name: "",
	  								email: "user@invalid",
	  								password: "foo",
	  								password_confirmation:"bar"}}
	 	end
	end

	test "valid sign up info" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, 
			params:{user: {name: "Valid Name", 
												email: "validemail@gmail.com",
												password: "password",
												password_confirmation: "password"}}		
		follow_redirect!
		end
		assert_template 'users/show'
		assert is_logged_in?
	end

end
