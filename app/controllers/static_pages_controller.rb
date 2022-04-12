# frozen_string_literal: true

# controls base html pages
class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help; end

  def about; end

  def users; end

  def contact; end

  def rails; end
end
