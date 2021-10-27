class LogController < ApplicationController
  def log
    lines = params[:lines]
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
  end
end