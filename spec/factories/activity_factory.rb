FactoryGirl.define do
  factory :activity, :class => Activity::Models::Activity do
    sequence(:application_id)
    sequence(:user_id)
    sequence(:title)        {|n| "Title ##{n}" }
    sequence(:content)      {|n| "Content ##{n}" }
  end
end
