require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'review cards without blocks' do
  describe 'training without cards' do
    before do
      create(:user)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end
end

describe 'review cards with one block' do
  describe 'training without cards' do
    before do
      create(:user_with_one_block_without_cards)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end

  describe 'training with two cards' do
    before do
      user = create(:user_with_one_block_and_two_cards)
      user.cards.each { |card| card.update_attribute(:review_date,
                                                     Time.now - 3.days) }
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'first visit' do
      expect(page).to have_content I18n.t('original_text_label')
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')

    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('correct_translation_notice')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('translation_from_misprint_alert',
       {user_translation: 'hous', original_text: 'дом', translated_text: 'house'});
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end
  end

  describe 'training with one card' do
    before do
      user = create(:user_with_one_block_and_one_card)
      user.cards.each { |card| card.update_attribute(:review_date,
                                                     Time.now - 3.days) }
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('no_review_card_text')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('translation_from_misprint_alert',
       {user_translation: 'hous', original_text: 'дом', translated_text: 'house'});
    end

    it 'correct translation quality=3' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('current_card_label')
    end

    it 'correct translation quality=4' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('check_card_button')
      fill_in 'user_translation', with: 'House'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end
end

describe 'review cards with two blocks' do
  describe 'training without cards' do
    before do
      create(:user_with_two_blocks_without_cards)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end

  describe 'training with two cards' do
    before do
      user = create(:user_with_two_blocks_and_one_card_in_each)
      user.cards.each { |card| card.update_attribute(:review_date,
                                                     Time.now - 3.days) }
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'first visit' do
      expect(page).to have_content I18n.t('original_text_label')
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('correct_translation_notice')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('translation_from_misprint_alert',
       {user_translation: 'hous', original_text: 'дом', translated_text: 'house'});
    end
  end

  describe 'training with one card' do
    before do
      user = create(:user_with_two_blocks_and_only_one_card)
      user.cards.each { |card| card.update_attribute(:review_date,
                                                     Time.now - 3.days) }
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('no_review_card_text')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('translation_from_misprint_alert',
       {user_translation: 'hous', original_text: 'дом', translated_text: 'house'});
    end
  end
end

describe 'review cards with current_block' do
  describe 'training without cards' do
    before do
      create(:user_with_two_blocks_without_cards, current_block_id: 1)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'no cards' do
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end

  describe 'training with two cards' do
    before do
      user = create(:user_with_two_blocks_and_two_cards_in_each)
      block = user.blocks.first
      user.set_current_block(block)
      card = user.cards.find_by(block_id: block.id)
      card.update_attribute(:review_date, Time.now - 3.days)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'first visit' do
      expect(page).to have_content I18n.t('original_text_label')
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('correct_translation_notice')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('translation_from_misprint_alert',
       {user_translation: 'hous', original_text: 'дом', translated_text: 'house'});
    end
  end

  describe 'training with one card' do
    before do
      user = create(:user_with_two_blocks_and_one_card_in_each)
      block = user.blocks.first
      user.set_current_block(block)
      card = user.cards.find_by(block_id: block.id)
      card.update_attribute(:review_date, Time.now - 3.days)
      visit trainer_path
      login('test@test.com', '12345', I18n.t('log_in_label'))
    end

    it 'incorrect translation' do
      fill_in 'user_translation', with: 'RoR'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation' do
      fill_in 'user_translation', with: 'house'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('no_review_card_text')
    end

    it 'incorrect translation distance=2' do
      fill_in 'user_translation', with: 'hou'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('incorrect_translation_alert')
    end

    it 'correct translation distance=1' do
      fill_in 'user_translation', with: 'hous'
      click_button I18n.t('check_card_button')
      expect(page).to have_content I18n.t('no_review_card_text')
    end
  end
end
