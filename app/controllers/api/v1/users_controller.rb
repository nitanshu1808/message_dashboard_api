class Api::V1::UsersController < ApplicationController
  # retrieves, creates and destroys user in json format

  include ExceptionHandler
  include RenderResponse

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
    @user = User.new(configure_user_params)
    if @user.save!
      render_response(@user, I18n.t("user.created"), I18n.t("app.success"), :created)
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
    @user = User.find_by!(id: params[:id])
  end
end
