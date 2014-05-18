class UsersController < ApplicationController
  def new
  end

  def profile
    @user = current_user
    @categories = Category.all
    @numCat = Category.count
    @myscores = Array.new(@numCat) 
    for i in 1..@numCat
      @myscores[i - 1] = Score.find_by_user_id_and_category_id(@user.id,i).score
    end 
    @myscores = @myscores.map{|x| x.to_i}
  end

  def create
  end

  def update
  end

  def index
  end
end
