# frozen_string_literal: true

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @fail = users(:failure)
  end

  test 'index including pagination' do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name if user.activated?
    end
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    get users_path

    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end

    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test 'redirect if user not activated' do
    get user_path(@fail)
    log_in_as(@fail)

    assert_not @fail.activated?
    assert_redirected_to root_path
  end
end
