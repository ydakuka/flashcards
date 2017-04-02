class AnalyticsController < ApplicationController
  def index
    @visits = Visit.all
    @events = Ahoy::Event.all
  end
end
