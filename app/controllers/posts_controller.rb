class PostsController < ApplicationController
  def index
    @search = Forms::Search.new

    @posts = SocialNetworks::Post.all.first(100)
  end
end