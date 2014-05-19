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
    # Storing the answers in an array
    # @answers = Array.new(@number_of_questions_part1 + @number_of_questions_part2)
    # @question_ids = Array.new(@number_of_questions_part1 + @number_of_questions_part2)
    # @answers1 = Array.new(@questions1)
    # @question_id1 = Array.new(@questions1)
    # @questions1.each_with_index do |question,index|
    #   @answers1[index] = question.answer
    #   @question_id1[index] = question.id
    # end 
    # @answers2 = Array.new(@questions2)
    # @question_id2 = Array.new(@questions2)
    # @questions2.each_with_index do |question,index|
    #   @answers2[index] = question.answer
    #   @question_id2[index] = question.id
    # end
    # @answers = @answers1+@answers2
    # @question_ids = @aquestion_id1+@question_id2

  end


  def answers

    set_up_instance_variables
    @score = 0
    @change = 0

    @question_ids = [params[:question_id1],params[:question_id2],params[:question_id3],params[:question_id4],params[:question_id5]]
    @questions = Array.new(@question_ids.count)
    @question_ids.each_with_index do |id,index|
      @questions[index] = Question.find(id)
    end

    #Array of selected answers
    @user_answers = [params[:ans1],params[:ans2],params[:ans3],params[:ans4],params[:ans5]]
    @user_answers = @user_answers.map {|x| x.to_i}
    #@real_answers = [params[:answer1],params[:answer2],params[:answer3],params[:answer4],params[:answer5]]

    # Calculation of score
    for i in 1..@number_of_questions_part1
      @score = @score + 10 if @user_answers[i-1] == @questions[i-1].answer
    end
    for i in 1..@number_of_questions_part2
      @score = @score + 20 if @user_answers[i-1 +@number_of_questions_part1] == @questions[i-1 +@number_of_questions_part1].answer
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

  def score
    set_up_instance_variables

    @score = params[:score]
    @change = params[:change].to_i
    
    
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
