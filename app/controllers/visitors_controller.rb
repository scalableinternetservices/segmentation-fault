class VisitorsController < ApplicationController
  def index
    fresh_when(User.all)
  end

end
