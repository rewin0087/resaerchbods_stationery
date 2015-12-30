class StationeriesController < ApplicationController
  before_filter :set_stationery, except: [:index, :new, :create]

  def index
    @stationeries = params[:admin] == '1' ? Stationery.all.page(params[:page]) : Stationery.in_stocks.page(params[:page])
  end

  def new
    @stationery = Stationery.new
  end

  def create
    @stationery = Stationery.new(stationery_params)

    if @stationery.valid? && @stationery.save
      redirect_to stationeries_path(admin: params[:admin]), notice: 'Successfully Added New Stationery.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @stationery.assign_attributes(stationery_params)

    if @stationery.valid? && @stationery.save
      redirect_to stationeries_path(admin: params[:admin]), notice: 'Successfully Updated Stationery.'
    else
      render :edit
    end
  end

  def destroy
    redirect_to stationeries_path(admin: params[:admin]), notice: 'Successfully Deleted Stationery.' if @stationery.destroy
  end

  private

  def stationery_params
    params.require(:stationery).permit(:name, :code, :stationery_type, :in_stocks)
  end

  def set_stationery
    @stationery = Stationery.find params[:id]
  end
end
