require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark.rb'
require 'pg'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb(:'bookmarks/index')
  end

  get '/bookmarks/new' do
    erb(:'bookmarks/new')
  end

  post '/bookmarks' do
    Bookmark.create(params[:url], params[:title])
    redirect ('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect ('/bookmarks')
  end

end