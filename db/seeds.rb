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

USERS = 10
CATEGORIES = 5
TESTS = 10
QUESTIONS = 30
ANSWERS = 50
CORRECTNESS = true

hash_users = USERS.times.map.with_index do |num|
  {
    name: FFaker::Internet.user_name[0...16],
    age: Random.rand(15..60),
    email: FFaker::Internet.safe_email,
    password: Random.rand(1000..9999),
  }
end
users = User.create!(hash_users)


hash_categories = CATEGORIES.times.map do 
  {
    title: FFaker::BaconIpsum.word,
  }
end
categories = Category.create!(hash_categories)


hash_tests = TESTS.times.map do
  {
    title: FFaker::BaconIpsum.word,
    level: Random.rand(0..10),
    category: categories.sample,
    author: users.first
  }
end
tests = Test.create!(hash_tests)


hash_questions = QUESTIONS.times.map do
  {
    body: FFaker::BaconIpsum.sentence,
    test: tests.sample,
  }
end
questions = Question.create!(hash_questions)


hash_answers = ANSWERS.times.map do
  {
    body: FFaker::BaconIpsum.word,
    question: questions[rand(QUESTIONS)],
    correct: CORRECTNESS,
  }
end
answers = Answer.create!(hash_answers)

