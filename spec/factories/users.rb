FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password '12345'
    password_confirmation '12345'
    locale 'ru'
    current_block_id ''

    factory :user_with_one_block_without_cards do
      after(:create) do |user|
        create(:block, user: user)
      end
    end

    factory :user_with_two_blocks_without_cards do
      after(:create) do |user|
        create(:block, user: user)
        create(:block, user: user)
      end
    end

    factory :user_with_one_block_and_one_card do
      after(:create) do |user|
        create(:block_with_one_card, user: user)
      end
    end

    factory :user_with_one_block_and_two_cards do
      after(:create) do |user|
        create(:block_with_two_cards, user: user)
      end
    end

    factory :user_with_two_blocks_and_one_card_in_each do
      after(:create) do |user|
        create(:block_with_one_card, user: user)
        create(:block_with_one_card, user: user)
      end
    end

    factory :user_with_two_blocks_and_only_one_card do
      after(:create) do |user|
        create(:block, user: user)
        create(:block_with_one_card, user: user)
      end
    end

    factory :user_with_two_blocks_and_two_cards_in_each do
      after(:create) do |user|
        create(:block_with_two_cards, user: user)
        create(:block_with_two_cards, user: user)
      end
    end
  end
end
