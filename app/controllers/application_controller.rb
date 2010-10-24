class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  protected
  
  # OAUTH
  
  def oauth_consumer(service)
    if service == "myspace"
      @oauth_consumer ||= OAuth::Consumer.new(auth_config[service]['key'], auth_config[service]['secret'], :site => auth_config[service]['base_url'],
        :http_method => "get",
        :request_token_path => "/request_token",
        :access_token_path => "/access_token",
        :authorize_path => "/authorize"
      )
      
    elsif service == "digg"
      @oauth_consumer ||= OAuth::Consumer.new(auth_config[service]['key'], auth_config[service]['secret'], :site => auth_config[service]['base_url'],
        :request_token_url => "http://services.digg.com/oauth/request_token",
        :access_token_url => "http://services.digg.com/oauth/access_token"
      )
      
    else
      @oauth_consumer ||= OAuth::Consumer.new(auth_config[service]['key'], auth_config[service]['secret'], :site => auth_config[service]['base_url'])
    end
  end
  
  def oauth_token(service)
    if service == "soundcloud"
      @oauth_token ||= OAuth::AccessToken.new(oauth_consumer(service), Settings.token, Settings.secret)
    else
      @oauth_token ||= OAuth::AccessToken.new(oauth_consumer(service), session[:user][:token], session[:user][:secret])
    end
  end
  
  # OAUTH 2
  
  def oauth2_client
    @oauth2_client ||= OAuth2::Client.new(auth_config['facebook']['app_id'], auth_config['facebook']['secret'], :site => auth_config['facebook']['base_url'])
  end
  
  def oauth2_token
    @oauth2_token ||= OAuth2::AccessToken.new(oauth2_client, session[:user][:token])
  end
  
  # CONFIG
  
  def auth_config
    @auth_config = YAML.load(File.open(File.join(Rails.root, 'config', 'auth.yml')).read)[Rails.env]
  end
end
