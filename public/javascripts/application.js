// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({    
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}    
});

jQuery.fn.submitWithAjax = function () {
  this.submit(function () {
    $.post($(this).attr('action'), $(this).serialize(), null, "script");    
    return false;
  });    
};

jQuery.fn.getWithAjax = function() {
  this.click(function() {
    $.get($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  });
};

$(document).ready(function(){
	$('#new_answer').submitWithAjax();//回答问题
	$('#new_message').submitWithAjax();//添加新的消息
	$('#content form.new_reply').submitWithAjax();//消息回复
	$('#content form.button-to').submitWithAjax();//问题投票
	$('#answer a.set_right_answer').getWithAjax(); //选取正确答案
	$('#answer form.new_answer_comment').submitWithAjax();//问题答案的评论
	$('#favorite_question a').getWithAjax();
	$('.show-mainwords a').getWithAjax();
	$('.mainwords a').getWithAjax();
	$('#category_bar a').getWithAjax();
});


function replyboxShow(id){
    $('#NSreplybox_' + id).show();
    document.getElementById('NSreplylink_' + id).style.background = '#B5C5D7';
}

function replyboxHide(id){
   $('#NSreplybox_' + id).hide();
   document.getElementById('NSreplylink_' + id).style.background = 'none';
}

function commentboxShow(id){
    $('#NScommentbox_' + id).show();
    document.getElementById('NSreplylink_' + id).style.background = '#B5C5D7';
}

function commentyboxHide(id){
   $('#NScommentbox_' + id).hide();
   document.getElementById('NSreplylink_' + id).style.background = 'none';
}
