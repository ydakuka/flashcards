class Card < ApplicationRecord
  include Userable
  include Distancable

  mount_uploader :image, CardImageUploader

  belongs_to :block
  validates :user_id, presence: { message: 'Ошибка ассоциации.' }
  validates :block_id,
            presence: { message: 'Выберите колоду из выпадающего списка.' }

  scope :pending,   -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }
  scope :non_email, -> { where.not(email: nil) }

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
