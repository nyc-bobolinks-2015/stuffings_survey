$(document).ready(function() {

  $('form.create_survey').on('submit', function(event){
    event.preventDefault();
    
    sur_title = $('form.create_survey input#title').val()
    $.ajax({
       method: "post",
       url:    $(event.target).attr('action'),
       data:   $(event.target).serialize()
    }).done(function(response){
      
      survey_id = response
      $('h3.survey_name').text(sur_title.toUpperCase())
      $('form.create_survey').remove();
      $('div.add_question').toggle(250);
    });
  });

  $('div.survey').on('click', 'button.question', function(event){
    event.preventDefault();

    $.ajax({
      method: "post",
      url:    "/surveys/add_question",
      data:   $(event.target).serialize()
    }).done(function(response){
      $('div.add_question').toggle(250);
      $('div.add_question').parent().append(response);
    });
  });

  $('div.survey').on('click', 'button.choice', function(event){
    event.preventDefault();
    
    $.ajax({
      url: "/surveys/add_choice" 
    }).done(function(response){
      $(event.target).parents().first().append(response);
    });
  });

  $('div.survey').on('click', 'button.complete_question', function(event){
    event.preventDefault();
    
    newArray = []
    for(var i = 0; i < $('input').toArray().length; i++){
      newArray.push($('input').toArray()[i].value);
    }
    newArray.push(survey_id);
    
    $.ajax({
      method: "post",
      url:    "/surveys/complete_question",
      data:   {question: newArray}
    }).done(function(response){
      
      $('div.add_question').children().remove();
      $('div.add_question').parent().append(response);
    });
  });

  $('div.survey').on('click', 'button.complete_survey', function(event){
    event.preventDefault();
    newArray = []
    for(var i = 0; i < $('input').toArray().length; i++){
      newArray.push($('input').toArray()[i].value);
    }
    newArray.push(survey_id);
    
    $.ajax({
      method: "get",
      url:    "/surveys/complete_survey",
      data:   {question: newArray}
    }).done(function(response){
      $('div.add_question').children().remove();
      $('div.all_done').toggle(250);
    });
  });

  $('div.survey').on('click', 'button.done', function(event){
    event.preventDefault();
    location.href = "/surveys";
  });

  $('#question-container').on('submit', '#question-display', function(event){
    event.preventDefault();
    var selected = $('input:radio[name=choice]:checked').val();    

    $.ajax({
      method: "post",
      url: $(event.target).attr('action'),
      data: {choice: selected}
    }).done(function(response){
      $('#question').replaceWith(response)
    }).fail(function(error){
      alert("Error:" + error)
    })
  });

});