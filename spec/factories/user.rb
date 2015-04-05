FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com"}
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now

    factory :user_with_post_and_comment do
      transient do
        num_comments 1
      end

      after(:build) do |user, evaluator|
        post = create(:post, user: user)
        #Alternative solution
        create_list(:comment, evaluator.num_comments, user: user, post: post)
        # evaluator.num_comments.times  {
          # comment = create(:comment, user: user, post: post)
        # }
      end
    end
  end

  
end