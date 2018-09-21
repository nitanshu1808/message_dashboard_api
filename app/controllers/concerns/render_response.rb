module RenderResponse
  extend ActiveSupport::Concern

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
  