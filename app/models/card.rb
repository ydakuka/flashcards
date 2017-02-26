class Card < ApplicationRecord
  include Userable
  include Distancable

  mount_uploader :image, CardImageUploader

  belongs_to :block
  validates :user_id, presence: { message: 'Ошибка ассоциации.' }
  validates :block_id, presence: { message: 'Выберите колоду из выпадающего списка.' }

  scope :pending,   -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }
  scope :non_email, -> { where.not(email: nil) }

  def self.flickr_search(query)
    require 'flickraw'
    FlickRaw.api_key = Rails.application.secrets.flickr_api_key
    FlickRaw.shared_secret = Rails.application.secrets.flickr_api_secret

    page = 1
    per_page = 10

    flickr.photos.search page: page, per_page: per_page, text: query,
                         tags: query, privacy_filter: 1
  end

  private

  def self.pending_cards_notification
    users = User.non_email
    users.each do |user|
      if user.cards.pending.any?
        CardsMailer.pending_cards_notification(user.email).deliver
      end
    end
  end
end
