class HomeController < ApplicationController
  def home
    @writing_images = WritingImage.all.where(published:true)
    @writing_definitions = WritingDefinition.all
    @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()'))
  end
  
  def index
    lines = params[:lines] ? params[:lines] : 1000
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
    @writing_images = WritingImage.all.where(published:true)
    @writing_definitions = WritingDefinition.all
    @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()'))
  end
end
