module SessionExtension
  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def default_user
    @default_user ||= DefaultUser.first.user
  end

  def owner
    name = params[:nickname]
    name ? User.find_by(nickname: name) : default_user
  end
end