require 'rubygems'
require 'sinatra/base'

begin
  require 'sinatra/reloader'
rescue LoadError
  puts "#{$!}. Run 'gem install sinatra-contrib' to fix this error."
  exit
end
require 'auth/auth_ext'
require 'model/routine'

class IndexModule < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

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

    set :bind, '0.0.0.0'
    set :sessions, true
    use Rack::Session::Cookie, :key => 'rack.session',
                               :expire_after => 31536000,
                               :secret => config[:cookie_secret]
    set :session_secret, config[:cookie_secret]

    set :app_name, 'Liftstream'
    set :port, config['port']
    set :protection, :except => :json_csrf
  end

  before do
    @js = ['/js/main.js']
    @css = ['/css/main.css']
  end

  helpers do
    def partial(page, options={})
      erb page.to_sym, options.merge!(:layout => false)
    end
  end

  def page_title
    page = @title ? "#{@title} - " : ""
    return "#{page}#{settings.app_name}"
  end

  get '/' do
    if session[:user]
      redirect '/routines'
    else
      @css.push( '/css/login.css' )
      @js.push( '/js/login.js' )
      @header = "Liftstream"
      @footer = partial(:footer)
      @title = "Home"
      @page = "home"
      erb :index
    end
  end

  get '/account' do
    if session[:user]
      user = session[:user]
      @css.push( '/css/account.css' )
      @header = "Account"
      @footer = partial(:footer)
      @page = "account"
      @title = "Welcome, #{user.email}"
    erb :account
    else
      redirect '/' #de-dupe the "if youre not logged in, redirect to login page" logic
    end
  end

  get '/routines' do
    if session[:user]
      user = session[:user]
      @css.push( '/css/routines.css' )
      @js.push( '/js/routines.js' )
      @early = partial(:early)
      @nav = [{
        :url => '/account',
        :label => 'Settings',
        :child_urls => ['account/profile']
      }]
      @title = "Routines for #{user.email}"
      @page = "routines"
      @routines = Routine.all(:user_id => user.id)
      erb :routines
    else
      redirect '/' #de-dupe the "if youre not logged in, redirect to login page" logic
    end
  end

  post '/routine' do
    # delete old exercises
    routine_id = params[:routine_id]
    RoutineExercise.all(:routine_id => routine_id).destroy

    # get and update routine
    routine = Routine.get(routine_id)
    routine.name = params[:name]
    routine.description = params[:description]

    # create new exercises and sort them
    exercises = []
    params.each() do |key, value|
      if key.start_with?('name_')
        old_id = key.split('_')[1]
        sort = params["sort_#{old_id}".to_sym]
        puts "#{old_id} - #{sort}"
        re = RoutineExercise.new(:name => value, :sort => sort)
        exercises << re
      end
    end
    exercises.sort { |a, b| a.sort <=> b.sort }

    # add new exercises to the routine
    for exercise in exercises do
      routine.routine_exercises << exercise
      exercise.save
    end

    #save
    routine.save

    redirect '/routines'
  end

  post '/add-routine' do
    if session[:user]
      user = session[:user]
      r = Routine.create(:name=> 'New Routine', :user_id => user.id)
      r.errors.each do |error|
        puts error
      end
      redirect '/routines'
    else
      redirect '/' #de-dupe the "if youre not logged in, redirect to login page" logic
    end
  end

  post '/add-routine-exercise' do
    r = Routine.get(params[:routine_id])
    re = RoutineExercise.create(:name => 'New Exercise', :sort => r.routine_exercises.last.sort+1)
    r.routine_exercises << re
    r.save
    re.save
    redirect '/routines'
  end

  run! if app_file == $0
end