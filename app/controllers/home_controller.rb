class HomeController < ApplicationController
  def home
    @writing_images = WritingImage.all
  end
end
