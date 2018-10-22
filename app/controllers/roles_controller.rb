
# Role related class controller
class RolesController < ApplicationController

  def show_role
    render json: { role: @current_user.role_id }, status: :ok
  end

  def set_role
    @current_user.role_id = params[:role_id]
    @current_user.save!
    show_role
  end

end
