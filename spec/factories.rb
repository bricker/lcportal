def do_password(user, eval)
  if eval.overwrite_password
    user.update_attribute(:password, eval.password)
    user.reload
  end
end

include ActionDispatch::TestProcess

FactoryGirl.define do   
  trait :user do
     name "Bryan Ricker"
     password "secret"
     sequence(:email) { |i| "user#{i}@liquidcinema.com"}

     ignore do
       overwrite_password true
     end
   end
   
  factory :user, traits: [:user] do
    after_create do |user, eval|
      do_password(user, eval)
    end
  end
  
  factory :writer, traits: [:user] do
    after_create do |user, eval|
      do_password(user, eval)
    end
  end
  
  factory :admin, traits: [:user] do
    after_create do |user, eval|
      do_password(user, eval)
    end
  end

  factory :profile do
    writer
    phone_number "555-9876"
    address "123 Fake St.
             Santa Monica, CA
             91004"
  end
  
  factory :statement do
    writer
    asset { fixture_file_upload(File.join(Rails.root, 'spec', 'support', 'test-upload.pdf'), 'application/pdf') }
  end
end
