require 'rubygems'
require 'sinatra/base'
require 'auth/auth_ext'
require 'model/routine'

class IndexModule < Sinatra::Base
  register Sinatra::Auth

  configure do
    internal_config = 'config.yaml'
    external_config = '/etc/brycecube/workouttracker.yaml'

    config = YamlConfig.new( internal_config ).override( external_config )
    config.each do |key, value|
      set key.to_sym, value
    end

    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "#{config['db']['protocol']}://#{config['db']['username']}:#{config['db']['password']}@#{config['db']['host']}/#{config['db']['database']}")
    DataMapper.finalize

    set :sessions, true
    use Rack::Session::Cookie, :key => 'rack.session',
                               :expire_after => 31536000,
                               :secret => config[:cookie_secret]
    set :session_secret, config[:cookie_secret]

    set :app_name, 'Workout Tracker'
    set :port, config['port']
    set :protection, :except => :json_csrf
  end

  before do
    @js = ['/js/main.js']
    @css = ['/css/main.css']
    # @nav = [
    #         { :url => '/',              :label => 'Home',    :child_urls => []},
    #         { :url => '/account',       :label => 'Profile',      :child_urls => ['account/profile'] },
    #       ]
  end

  get '/' do
    @css.push( '/css/login.css' )
    @js.push( '/js/login.js' )
    @page_title = "#{settings.app_name} - Home"

    erb :index
  end

  get '/routines' do
    if session[:user]
      user = session[:user]
      @page_title = "#{settings.app_name} - Routines for #{user.email}"
      @routines = Routine.all(:user_id => user.id)
      erb :routines
    else
      'Please log in first'
    end
  end

  run! if app_file == $0
end