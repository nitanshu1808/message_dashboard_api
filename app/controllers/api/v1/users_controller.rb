class Api::V1::UsersController < ApplicationController
  # fetching user
  before_action :get_user, only: [:show, :destroy]

  def index
    users = User.page( params[:page])
    render_response(users, I18n.t("user.load"), I18n.t("app.success"), :ok, users.total_pages)
  end

  def show
    render_response(@user, I18n.t("user.find"))
  end

  def create
    user = User.new(configure_user_params)
    if user.save
      render_response(user, I18n.t("user.created"))
    else
      render_response(user.errors, I18n.t("user.error"), I18n.t("app.error"), :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy && render_response(@user, I18n.t("user.delete"))
  end

  # private methods
  private
  def configure_user_params
    params[:user] && params.require(:user).permit(:email, :first_name, :last_name, :amount)
  end

  def get_user
    @user = User.find_by(id: params[:id])
    render_response([], I18n.t("user.not_found"), I18n.t("app.error")) and return if @user.nil?
  end

  def render_response(data, msg, status = I18n.t("app.success"), res_status = :ok, total_pgs=nil)
    respns = {
              status:   status, 
              message:  msg, 
              data:     data
            }

    respns.merge!({total_pages: total_pgs}) if total_pgs
    render json: respns, status: res_status
  end
  
end
