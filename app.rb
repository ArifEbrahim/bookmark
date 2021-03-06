require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/bookmark.rb'
require './database_connection_setup.rb'
require 'uri'
require './lib/comment.rb'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb(:'/bookmarks/home')
  end

  get '/bookmarks' do
    @user = User.find(session[:user_id])
    @bookmarks = Bookmark.all
    erb(:'bookmarks/index')
  end

  get '/bookmarks/new' do
    erb(:'bookmarks/new')
  end

  post '/bookmarks' do
    flash[:notice] = 'Please submit a valid url' unless Bookmark.create(params[:url], params[:title])
    redirect ('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect ('/bookmarks')
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb(:'bookmarks/edit')
  end

  patch '/bookmarks/:id' do
    Bookmark.update(params[:url], params[:title], params[:id])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb(:'comments/new')
  end

  post '/bookmarks/:id/comments' do
    Comment.create(params[:comment], params[:id])
    redirect('/bookmarks')
  end

  get '/users/new' do
    erb(:'users/new')
  end

  post '/users' do
    user = Users.create(params[:email], params[:password])
    session[:user_id] = user.id
    redirect('/bookmarks')
  end
end