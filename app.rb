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
    erb(:index)
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb(:bookmarks)
  end

  get '/new' do
    erb(:new)
  end

  post '/save' do
    Bookmark.create(params[:url], params[:title])
    redirect ('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect ('/bookmarks')
  end

end