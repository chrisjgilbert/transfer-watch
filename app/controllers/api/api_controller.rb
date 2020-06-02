module Api
  class ApiController < ApplicationController
    def index
      @rumours = Rumour.all
      render :json => @rumours
    end
  end
end


