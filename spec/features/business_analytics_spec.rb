require 'rails_helper'
include LoginHelper

feature "using ahoy_mater gem" do
  describe 'when user registered' do
    it 'when registred is true' do
      visit root_path
      register('test@test.com', '123456', '123456', I18n.t('sing_up_label'))
      expect(Ahoy::Event.last.name).to eq "user:registered"
    end
  end

  describe "when user logged with sorcery" do
    before do
      @card = create(:user_with_one_block_and_one_card)
      visit root_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    describe "when logged is true" do
      it "has Visit counted" do
        expect(Visit.count).to eq 1
      end

      it "has Ahoy::Event counted" do
        expect(Ahoy::Event.count).to eq 1
      end

      it "Ahoy::Event has right name" do
        expect(Ahoy::Event.first.name).to eq "sorcery:logged"
      end
    end

    describe "the user reviewed the card" do
      before do
        @controller = Dashboard::TrainerController.new
      end

      it "has Ahoy::Event has right name for two last events" do
        visit trainer_path
        within("#trainer_content form") do
          fill_in 'user_translation', with: 'house'
          click_button I18n.t('check_card_button')
        end

        expect(Ahoy::Event.offset(1).last.name).to eq "card:reviewed"
        expect(Ahoy::Event.last.name).to eq "Viewed trainer#index"
      end
    end

    describe "the user added the card" do
      before do
        @block = Block.last
      end

      it "without image" do
        visit new_card_path
        within("form#new_card") do
          fill_in I18n.t('original_text_label'),   with: 'дом'
          fill_in I18n.t('translated_text_label'), with: 'house'
          select @block.title, from: 'card[block_id]'
          click_button I18n.t('save')
        end

        expect(Ahoy::Event.offset(3).last.name).to eq "Viewed cards#new"
        expect(Ahoy::Event.offset(2).last.name).to eq "Viewed cards#create"
        expect(Ahoy::Event.offset(1).last.name).to eq "card:added"
        expect(Ahoy::Event.last.name).to eq "Viewed cards#index"
      end

      # it "with image using flickr service", js: true do
      #   visit new_card_path
      #   click_link I18n.t('upload_from_flickr')

      #   within("#flickrSearch form") do
      #     fill_in 'query', with: 'cats'
      #     click_button I18n.t('find_in_flickr')
      #   end

      #   within("form#new_card") do
      #     fill_in I18n.t('original_text_label'),   with: 'дом'
      #     fill_in I18n.t('translated_text_label'), with: 'house'
      #     select @block.title, from: 'card[block_id]'
      #     click_button I18n.t('save')
      #   end

      #   visit root_path

      #   expect(Ahoy::Event.offset(4).last.name).to eq "Viewed cards#new"
      #   expect(Ahoy::Event.offset(3).last.name).to eq "Viewed cards#flickr_photos_search"
      #   expect(Ahoy::Event.offset(2).last.name).to eq "Viewed cards#create"
      #   expect(Ahoy::Event.offset(1).last.name).to eq "card:added"
      #   expect(Ahoy::Event.last.name).to eq "Viewed cards#index"
      # end
    end
  end
end
