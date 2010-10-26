module ApplicationHelper
  def is_ios?
    request.env["HTTP_USER_AGENT"] && 
      (request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/] || 
       request.env["HTTP_USER_AGENT"].include?('iPhone') || 
       request.env["HTTP_USER_AGENT"].include?('iPad'))
  end
end
