require "rails_helper"
include LoginHelper

feature "User connects Flickr photos to card" do
  before do
    create(:user_with_one_block_without_cards)
    visit trainer_path
    login('test@test.com', '12345', I18n.t('log_in_label'))
    visit new_card_path
  end

  it 'should be link Загрузить из Flickr' do
    expect(page).to have_content('Загрузить из Flickr')
  end

  it 'should be link Найти во Flickr' do
    click_link 'Загрузить из Flickr'
    expect(page).to have_button('Найти во Flickr')
  end

  # it 'with word test in search input' do
  #   click_link 'Загрузить из Flickr'
  #   fill_in 'query', with: 'cats'
  #   skip('Неудается обработать click_button')
  #   # click_button 'Найти во Flickr'
  #   # stub_request(:any, "api.flickr.com")
  #   # Net::HTTP.get('api.flickr.com', '/')
  # end
end
