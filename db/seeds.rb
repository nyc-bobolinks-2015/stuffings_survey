arc = User.create({username: "arc", email: "arc@arc.com", password: "arc"}),

courtney = User.create({username: "courtney", email: "courtney@courtney.com", password: "courtney"}),

miguel = User.create({username: "miguel", email: "miguel@miguel.com", password: "miguel"}),

michael = User.create({username: "michael", email: "michael@michael.com", password: "michael"}),

survey1 = Survey.create({user_id: 1, title: "Ancient Civilizations", description: "A survey about civilizations."}),

question1 = Question.create({survey_id: 1, text: "Which is your favorite ancient civilization?"}),

question2 = Question.create({survey_id: 1, text: "Who is your favorite ancient figure?"}),

choice1 = Choice.create([{question_id: 1, text: "Rome"}, {question_id: 1, text: "Babylon"}, {question_id: 1, text: "Aztec"}, {question_id: 1, text: "Siam"}])

choice2 = Choice.create([{question_id: 2,text: "Julius Caesar"},{question_id: 2,text: "Mansa Musa"}, {question_id: 2,text: "Archimedes"}, {question_id: 2,text: "Confucius"}])


answer1 = Answer.create([{user_id: 1, survey_id: 1, question_id: 1, choice_id: 1},
						  {user_id: 2, survey_id: 1, question_id: 1, choice_id: 2 }, 
						  {user_id: 3, survey_id: 1, question_id: 1, choice_id: 1 },
						  {user_id: 4, survey_id: 1, question_id: 1, choice_id: 4 }]),

answer2 = Answer.create([{user_id: 1, survey_id: 1, question_id: 2, choice_id: 2},
						  {user_id: 2, survey_id: 1, question_id: 2, choice_id: 2}, 
						  {user_id: 3, survey_id: 1, question_id: 2, choice_id: 1},
						  {user_id: 4, survey_id: 1, question_id: 2, choice_id: 2}])
