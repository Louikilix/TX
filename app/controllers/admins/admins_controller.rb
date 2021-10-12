class Admins::AdminsController < Admins::ApplicationController

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new permitted_params
    if @admin.save
      flash[:success] = t("admins.flash_messages.admins.create.success")
      redirect_to admins_admins_url
    else
      render :edit
    end
  end

  def edit
    @admin = Admin.find(params[:id])
   end

  def update
    @admin = Admin.find(params[:id])

    if @admin.update(permitted_params)
      bypass_sign_in(@admin) if @admin == current_admin
      flash[:success] = t("admins.flash_messages.admins.update.success")
      redirect_to edit_admins_admin_url(@admin)
    else
      render "edit"
    end

  end

  def destroy
    @admin = Admin.find params[:id]
    if @admin.destroy
      flash[:success] = t("admins.flash_messages.admins.destroy.success")
    else
      flash[:error] = t("admins.flash_messages.admins.destroy.error")
    end
    redirect_to admins_admins_url
  end
 end

