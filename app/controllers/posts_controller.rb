class PostsController < ApplicationController
  def home
    @products = Product.all
  end
end
