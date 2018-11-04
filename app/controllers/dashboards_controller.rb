class DashboardsController < ApplicationController
  def show
    @shout = Shout.new
    @shouts = current_user.timeline_shouts
    render
  end
end
