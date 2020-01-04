FactoryBot.define do
  factory :user, aliases: [ :owner ] do
    first_name "Aaron"
    last_name "Sumner"
    sequence(:email) { |n| "test#{n}@example.com" }
    password "dottele-nouveaus-valion"
  end
end
