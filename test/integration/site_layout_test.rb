# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  ### NOT USER!

  test 'no user layout links' do
    get root_path

    assert_select 'title', full_title('')
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', login_path
  end

  ### LOGGED IN!

  test 'logged in layout links' do
    log_in_as(@user)
    get root_path

    assert_select 'title', full_title('')
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a[href=?]', logout_path
  end
end
