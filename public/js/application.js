$(document).ready(function() {

  $('button.question').on('click', function(event){
    event.preventDefault();

    $.ajax({
      url: "/surveys/add_question" 
    }).done(function(response){
      $('div.add_question').append(response);
    });
  });

  $('div.add_question').on('click', 'button.choice', function(event){
    event.preventDefault();
    
    $.ajax({
      url: "/surveys/add_choice" 
    }).done(function(response){
      // debugger
      $(event.target).parents().first().append(response);
    });
  });

  $('form.finish_survey').on('submit', function(event){
    event.preventDefault();
    

    // $('div.add_question').children().serialize();
    debugger
    $.ajax({
      method: "post",
      url:    $(event.target).attr('action'),
      data: $(event.target).serialize()
    })
  });

});