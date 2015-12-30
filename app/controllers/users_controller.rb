class UsersController < ApplicationController
  before_filter :set_user, except: [:index]

  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)

    if @user.valid? && @user.save
      redirect_to users_path(admin: params[:admin]), notice: 'Successfully Updated User detail.'
    else
      render :edit
    end
  end

  def stationeries_history
    @stationeries = @user.user_stationeries.page(params[:page])
  end

  def borrow_stationery
    @user_stationery = @user.user_stationeries.new
    @user_stationery.stationery_id = params[:stationery] if params[:stationery]

    if params[:user_stationery]
      @user_stationery.assign_attributes(user_stationery_params)

      if @user_stationery.valid? && @user_stationery.save
        redirect_to stationeries_path(admin: params[:admin]), notice: 'Successfully Borrowed a Stationery.'
      end
    end
  end

  def clear_stationery
    @stationery = @user.user_stationeries.find params[:stationery]
    @stationery.cleared!
    redirect_to stationeries_path(admin: params[:admin]), notice: 'Borrowed stationery is cleared.'
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :status, :full_name)
  end

  def user_stationery_params
    params.require(:user_stationery).permit(:user_id, :stationery_id)
  end
end
