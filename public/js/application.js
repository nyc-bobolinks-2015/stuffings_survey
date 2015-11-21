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

  $('')

});