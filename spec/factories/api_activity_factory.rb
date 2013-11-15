FactoryGirl.define do
  factory :api_activity, class: Hash do
    sequence(:application_id)
    sequence(:user_id)
    sequence(:content)      {|n| "Content ##{n}" }
    sequence(:title)        {|n| "Title ##{n}" }

    initialize_with { attributes }
  end
end
