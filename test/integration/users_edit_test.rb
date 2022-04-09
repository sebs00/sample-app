# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar' } }
    assert_template 'users/edit'
  end

  test 'number of errors are correct' do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: '',
                                              email: 'lol',
                                              password: '',
                                              password_confirmation: '' } }
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 4 errors.'
  end
end
