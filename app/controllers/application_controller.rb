class ApplicationController < ActionController::API
  before_action :authenticate_request, except: :authenticate_rem

  def authenticate_rem
    @current_user = AuthorizeApiRequest.call(request.headers).result
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def is_admin
    return render json: { error: 'Not Authorized' }, status: 401 unless admin?
  end

  def admin?
    @current_user.role.name.eql? 'admin'
  end

end