class PostsController < ApplicationController
  def index
    @search = Forms::Search.new(params['forms_search'])

    @posts = @search.search.first(100)
  end
end