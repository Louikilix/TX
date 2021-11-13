class HomeController < ApplicationController
  def home
    if seminar?
      @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()')) | WritingImage.joins(:writing_definitions).all.where("writing_definitions.author_published == true").all.order(Arel.sql('RANDOM()'))
    else
      @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()'))
    end
  end
  
  def index
    lines = params[:lines] ? params[:lines] : 1000
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
    @writing_definitions = WritingDefinition.all.order(Arel.sql('created_at DESC'))
  end

  def index2
    lines = params[:lines] ? params[:lines] : 1000
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
    @writing_definitions = WritingDefinition.all.order(Arel.sql('created_at DESC'))
  end

  def index2M
    lines = params[:lines] ? params[:lines] : 1000
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
    @writing_definitions = WritingDefinition.all.order(Arel.sql('created_at DESC'))
  end

  def index2Bin
    lines = params[:lines] ? params[:lines] : 1000
    if Rails.env == "production"
      @logs = `tail -n #{lines} log/production.log`
    else
      @logs = `tail -n #{lines} log/development.log`
    end
    @writing_definitions = WritingDefinition.all.order(Arel.sql('created_at DESC'))
  end
end
private
  def seminar?
    Admin.all.each do |a|
      return true if a.seminar
    end
    return false
  end