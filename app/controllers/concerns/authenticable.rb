module Authenticable
  def current_user
    return @current_user if @current_user.present?

    header = request.headers["Authorization"]
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end


  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end
end
