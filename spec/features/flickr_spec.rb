require "rails_helper"
include LoginHelper

feature "User connects Flickr photos to card" do
  before do
    create(:user_with_one_block_without_cards)
    visit trainer_path
    login('test@test.com', '12345', I18n.t('log_in_label'))
    visit new_card_path
  end

  it "has link 'Upload from flickr'" do
    expect(page).to have_content(I18n.t('upload_from_flickr'))
  end

  it "has link 'Find in Flickr'" do
    click_link I18n.t('upload_from_flickr')
    expect(page).to have_button(I18n.t('find_in_flickr'))
  end
end
