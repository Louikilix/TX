class Admins::AdminsController < Admins::ApplicationController


  def index
    @admins = Admin.all
  end

end


