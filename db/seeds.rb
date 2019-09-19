# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Category.destroy_all
Test.destroy_all
Question.destroy_all
Answer.destroy_all

# USERS = 10
# CATEGORIES = 5
# TESTS = 10
# QUESTIONS = 30
# ANSWERS = 50
# CORRECTNESS = true

# hash_users = USERS.times.map.with_index do |num|
#   {
#     name: FFaker::Internet.user_name[0...16],
#     email: FFaker::Internet.safe_email,
#     password: Random.rand(1000..9999),
#   }
# end
user = User.create!( name: 'Slevin Kelevra', email: 'example@mail.com', password: '123456')
admin = Admin.create!( name: 'John', age: 30, email: 'admin@mail.com', password: '123456' )

ruby = Category.create!(title: "Ruby" )
html = Category.create!(title: "HTML/CSS" )

test1 = Test.create!(title: "Ruby intro", level: 1, category_id: ruby.id, author_id: user.id)
test2 = Test.create!(title: "Ruby medium", level: 3, category_id: ruby.id, author_id: user.id)
test3 = Test.create!(title: "HTML", level: 2, category_id: html.id, author_id: user.id)
test4 = Test.create!(title: "CSS", level: 4, category_id: html.id, author_id: user.id)

questions = Question.create!(
  [{ body: "Can you call a private method outside a Ruby class using its object?", test_id: test1.id },
   { body: "How do you remove nil values in array using ruby?", test_id: test1.id },
   { body: "How many types of variables are used in Ruby and what are they?", test_id: test1.id },
   { body: "What are some advantages of using Ruby?", test_id: test2.id },
   { body: "Which levels of access control Ruby methods have?", test_id: test2.id },
   { body: "How would you freeze an object in Ruby?", test_id: test2.id },
   { body: "Alexander is required to write the chemical formula of dimisiac tetrasulfide (As2S4). How can this be done?", test_id: test3.id },
   { body: "Igor needs to make the width of the table the whole page (or the parent container). How does he need to write the <table> tag?", test_id: test3.id },
   { body: "Which tag does NOT exist:", test_id: test3.id },
   { body: "How to connect the stylesheet correctly?", test_id: test4.id },
   { body: "What CSS code is correct?", test_id: test4.id },
   { body: "What property is used to set fields for a block?", test_id: test4.id },
])

answers = Answer.create!(
  [{ body: "yes", correct: true, question_id: questions[0].id },
   { body: "no", correct: false, question_id: questions[0].id },
   { body: "using .fetch", correct: false, question_id: questions[1].id },
   { body: "using .compact", correct: true, question_id: questions[1].id },
   { body: "using .delete", correct: false, question_id: questions[1].id },
   { body: "using .uniq", correct: false, question_id: questions[1].id },
   { body: "class, instance variables", correct: false, question_id: questions[2].id },
   { body: "global, local variables", correct: false, question_id: questions[2].id },
   { body: "class, instance, global and local variables", correct: true, question_id: questions[2].id },
   { body: "pure object-oriented language", correct: false, question_id: questions[3].id },
   { body: "open-source & clean and simple syntax", correct: false, question_id: questions[3].id },
   { body: "metaprogramming", correct: false, question_id: questions[3].id },
   { body: "all of them", correct: true, question_id: questions[3].id },
   { body: "public & private", correct: false, question_id: questions[4].id },
   { body: "public & protected", correct: false, question_id: questions[4].id },
   { body: "private & protected", correct: false, question_id: questions[4].id },
   { body: "all of them", correct: true , question_id: questions[4].id },
   { body: "using .freeze", correct: true, question_id: questions[5].id },
   { body: "using .ice", correct: false, question_id: questions[5].id },
   { body: "using .frost", correct: false, question_id: questions[5].id },
   { body: "As<sup>2</sup>S<sup>4</sup>", correct: false, question_id: questions[6].id },
   { body: "As<sup>2S<sup>4", correct: false, question_id: questions[6].id },
   { body: "As<sub>2</sub>S<sub>4</sub>", correct: true, question_id: questions[6].id },
   { body: "As<pow>2</pow>S<pow>4</pow>", correct: false, question_id: questions[6].id },
   { body: "<table width='auto'>", correct: false, question_id: questions[7].id },
   { body: "<table width='100%''>", correct: true, question_id: questions[7].id },
   { body: "<table width='100'>", correct: false, question_id: questions[7].id },
   { body: "<table>", correct: false, question_id: questions[7].id },
   { body: "<ol>", correct: false, question_id: questions[8].id },
   { body: "<em>", correct: false, question_id: questions[8].id },
   { body: "<pre>", correct: false, question_id: questions[8].id },
   { body: "<adress>", correct: true, question_id: questions[8].id },
   { body: "<styles>@'styles/main.css'</styles>", correct: false, question_id: questions[9].id },
   { body: "<style>@'styles/main.css'</style>", correct: false, question_id: questions[9].id },
   { body: "<link rel='stylesheet' type='text/css' href='styles/main.css'/>", correct: true, question_id: questions[9].id },
   { body: "<style>@'styles/main.css'</style>", correct: false, question_id: questions[9].id },
   { body: "<div> {border: 1px solid #ccc;}", correct: false, question_id: questions[10].id },
   { body: "div {border: 1px solid #ccc;}", correct: true, question_id: questions[10].id },
   { body: "div {border: 1px solid #hhh;}", correct: false, question_id: questions[10].id },
   { body: "<div> {border: 1px solid #hhh;}", correct: false, question_id: questions[10].id },
   { body: "position", correct: false, question_id: questions[11].id },
   { body: "padding", correct: true, question_id: questions[11].id },
   { body: "direction", correct: false, question_id: questions[11].id },
   { body: "margin", correct: false, question_id: questions[11].id },
])