FactoryGirl.define do
  factory :block do
    title 'Block 1'
    user

    factory :block_with_one_card do
      after(:create) do |block|
        create(:card, user: block.user, block: block)
      end
    end

    factory :block_with_two_cards do
      after(:create) do |block|
        create(:card, user: block.user, block: block)
        create(:card, user: block.user, block: block)
      end
    end
  end
end
