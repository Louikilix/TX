class Admins::AdminsController < Admins::ApplicationController

 def index
        @users = Admin.all
    end

    # in case we need it later
    def show
      @admin = Admin.find_by_id(params[:id])
    end

    # 2 actions created for the creation of a new admin by another admin
    def new
        @admin = Admin.new
    end

    def create
        @admin = Admin.new(admin_params)
        if @admin.save
            redirect_to admins_root_url, notice: "admin succesfully created!" 
        else
            render :new
        end
    end

    # in case we need it later
    def edit
        @admin = Admin.find(params[:id])
    end

    # in case we need it later
    def update
        @admin = Admin.find(params[:id])
        if @user.update_attributes(admin_params)
            redirect_to admins_root_url, notice: "Updated admin."
        else
            render :edit
        end
    end


private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end


