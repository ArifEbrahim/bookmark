require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/bookmark.rb'
require './database_connection_setup.rb'
require 'uri'

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
    @bookmarks = Bookmark.all
    erb(:'bookmarks/index')
  end

  get '/bookmarks/new' do
    erb(:'bookmarks/new')
  end

  post '/bookmarks' do
    flash[:notice] = 'You must submit a valid url' unless Bookmark.create(params[:url], params[:title])
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

end