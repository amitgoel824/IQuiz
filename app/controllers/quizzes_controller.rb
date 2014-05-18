class QuizzesController < ApplicationController
	skip_before_action :verify_authenticity_token
  def category
  	@categories = Category.all
  end

  def questions

    set_up_instance_variables

    #Selecting questions randomly from chosen category
    @questions1 = Question.where(category_id: @category_id, stars: 1).order("RANDOM()").sample(@number_of_questions_part1)
    @questions2 = Question.where(category_id: @category_id, stars: 2).order("RANDOM()").sample(@number_of_questions_part2)
    @count = @questions1.count

    # Storing the answers in an array
    @answers = Array.new(@number_of_questions_part1 + @number_of_questions_part2)
    @answers1 = Array.new(@questions1)
    @questions1.each_with_index do |question,index|
      @answers1[index] = question.answer
    end 
    @answers2 = Array.new(@questions2)
    @questions2.each_with_index do |question,index|
      @answers2[index] = question.answer
    end
    @answers = @answers1+@answers2


  end


  def score
    set_up_instance_variables
    @score = 0
    @change = 0

    #Array of selected answers and actual answers
    @user_answers = [params[:ans1],params[:ans2],params[:ans3],params[:ans4],params[:ans5]]
    @real_answers = [params[:answer1],params[:answer2],params[:answer3],params[:answer4],params[:answer5]]

    # Calculation of score
    for i in 1..@number_of_questions_part1
      @score = @score + 10 if @user_answers[i-1] == @real_answers[i-1]
    end
    for i in 1..@number_of_questions_part2
      @score = @score + 20 if @user_answers[i-1 +@number_of_questions_part1] == @real_answers[i-1 +@number_of_questions_part1]
    end

    #Current high-score of user in selected category
    @temp = Score.find_by_user_id_and_category_id(@user_id,@category_id)
    @current_high_score = @temp.score

    @change = 1 if @score > @current_high_score
    if @change == 1
      @temp.score = @score
      @temp.save
    end
  end

  private

  def set_up_instance_variables

     # Identifying the user
    @user_id = current_user.id

    #Category chosen by the user
    @category_id = params[:category]

    #Number of questions of each type(based on stars)
    @number_of_questions_part1 = 3
    @number_of_questions_part2 = 2

  end
end
