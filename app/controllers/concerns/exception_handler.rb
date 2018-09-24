module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_response(e.message, I18n.t("user.not_found"), I18n.t("app.error"), :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_response(@user.errors.full_messages, I18n.t("user.error"), I18n.t("app.error"), :ok)
    end
  end
end


