class HomeController < ApplicationController
  def home
    @writing_images = WritingImage.all.where(published:true)
  end
end
