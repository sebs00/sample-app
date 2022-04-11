# frozen_string_literal: true

# controls base html pages
class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
  end

  def help; end

  def about; end

  def users; end

  def contact; end

  def rails; end
end
