# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def truncate(text, length = 30, truncate_string = "...")
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end
  
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

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def login_required
    unless current_user
      redirect_to sign_in_path
      return false
    end
  end

  def require_no_user
    if current_user
      redirect_to root_url
      return false
    end
  end

  alias :logged_in? :current_user

  def user_id
    current_user.id
  end

end
