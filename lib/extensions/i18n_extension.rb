module I18nExtension
  def tf(*args)
    t(*args, scope: 'functional')
  end
  def tp(content, scope)
    t(content, scope: scope)
  end
  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end
end