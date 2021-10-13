class HomeController < ApplicationController
  def home
    @writing_images = WritingImage.all.where(published:true)
    @writing_definitions = WritingDefinition.all
    @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()'))
  end
  def index
    @writing_images = WritingImage.all.where(published:true)
    @writing_definitions = WritingDefinition.all
    @randomImage = WritingImage.all.where(published:true).order(Arel.sql('RANDOM()'))
  end
end
