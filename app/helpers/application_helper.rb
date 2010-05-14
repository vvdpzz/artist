# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def coderay(text)     
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do    
      content_tag("notextile",CodeRay.scan($3, $2).div(:css => :class, :line_numbers => :table))     
    end    
  end
  
  def check_browser_we_supported?
    webkit = request.env["HTTP_USER_AGENT"].downcase.include?('webkit')
    gecko = request.env["HTTP_USER_AGENT"].downcase.include?('firefox')
    opera = request.env["HTTP_USER_AGENT"].downcase.include?('presto')
    if webkit || gecko || opera
      return true
    else
      return false
    end 
  end

protected

    def login_required
      logged_in? || access_denied
    end
    
    def access_denied
      redirect_to(:controller => "sessions", :action => "new")
      false
    end
    
    def current_user
      @current_user ||= (login_from_session || false)
    end
    
    alias :logged_in? :current_user
    
    def current_user=(new_user)
      session[:user] = new_user && new_user.id
      @current_user = new_user
    end
    
    def login_from_session
      self.current_user = User.find_by_id(session[:user]) if session[:user]
    end
    
    def user_name
      User.find_by_id(session[:user]).name if session[:user]
    end
    
    def user_id
      session[:user]
    end
    
end
