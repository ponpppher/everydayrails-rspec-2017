FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "A test project"
    due_on 1.week.from_now
    association :owner

    factory :project_due_yesterday do
      due_on 1.day.ago
    end

    factory :project_due_today do
      due_on Date.current.in_time_zone
    end

    factory :project_due_tomorrow do
      due_on 1.day.from_now
    end

    # memoつき
    trait :with_notes do
      # 作成後, できたprojectを引数にしてnoteを5個紐付けてる
      after(:create) { |project| create_list(:note, 5, project: project)}
    end
  end
end