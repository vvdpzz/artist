module AnswersHelper
  def correct_answer(answer)
    html = ""
    if  answer.question.correct_answer != 0 and answer.question.correct_answer == answer.id
			return html = "#{image_tag("/images/answer-accepted-on.png", :width => 30)}"
		else
			if user_id == answer.question.user.id
				 return html = "#{ link_to "",
							{ :action => :set_correct_answer, :controller => :questions,
								:question_id => show_answer.question.id,
								:answer_id => show_answer.id},
							{ :class => "set_right_answer", :title=>"设为正确答案"} }"
      end
		end
  end
end
