require 'rubygems'
require 'sinatra/base'
require 'data_mapper'
require 'digest/sha2'
require 'auth/model/account'
require 'util/util'
require 'util/YamlConfig'

module Sinatra
  module Auth
    module Helpers
      def authorized?
        session[:user] != nil
      end

      def authorize!
        redirect '/login' unless authorized?
      end

      def logout!
        session[:user] = nil
      end
    end
    
    def self.registered(app)
      app.helpers Auth::Helpers
      
      app.before do
        @session = session
        @test = 'test'
      end
      
      app.get '/login' do
        @page_title = "#{settings.app_name} - Login"

        erb :auth_login
      end

      app.post '/login' do
        user = User.first( :email => params[:email], :password_hash => (Digest::SHA2.new << params[:password]).to_s )
        puts "#{user}"
        session[:user] = user
        redirect '/'
      end
      
      app.get '/register' do
        @page_title = "#{settings.app_name} - Register"

        erb :auth_register
      end

      app.post '/logout' do
        logout!
        redirect '/'
      end
      
      app.post '/register' do
        email = params[:email]
        password = params[:password]
        confirm_password = params[:confirm_password]

        if( password != confirm_password )
          @error = '"Password" and "Confirm Password" must match.'
          erb :auth_register
        else
          user = User.create( :email => email, :password_hash => (Digest::SHA2.new << password).to_s)
          
          user.errors.each do |error|
            puts error
          end
          # todo: login
          @page_title = "#{settings.app_name} - Thanks for registering"
          erb :auth_register_thanks
        end
      end

    end
  end

  register Auth
end
    
# class AccountModule < Sinatra::Base
#   enable :sessions, :logging
# 
#   INTERNAL_CONFIG_LOCATION = 'config.yaml'
#   EXTERNAL_CONFIG_LOCATION = '/etc/brycecube/workouttracker.yaml'
#   APP_NAME = 'Workout Tracker'
#   
#   config = YamlConfig.new( INTERNAL_CONFIG_LOCATION )
#   config = config.override( EXTERNAL_CONFIG_LOCATION )
#   
#   DataMapper::Logger.new($stdout, :debug)
#   DataMapper.setup(:default, "#{config['db']['protocol']}://#{config['db']['username']}:#{config['db']['password']}@#{config['db']['host']}/#{config['db']['database']}")
# 
#   configure do
#     set :port, config['port']
#     set :protection, :except => :json_csrf
#   end
# 
#   before do
#     @js = ['https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js', '/js/bootstrap.min.js']
#     @css = ['/css/bootstrap.min.css']
#     @nav = [
#             { :url => '/',              :label => 'Home',    :child_urls => []},
#             { :url => '/account',       :label => 'Profile',      :child_urls => ['account/profile'] },
#           ]
#   end
# end