class Card < ApplicationRecord
  include Userable
  include Distancable

  mount_uploader :image, CardImageUploader

  has_many :filling_results, dependent: :destroy
  belongs_to :block
  validates :user_id,  presence: { message: 'Ошибка ассоциации.' }
  validates :block_id, presence: { message: 'Выберите колоду из выпадающего списка.' }

  scope :pending,     -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating,   -> { where('quality < ?', 4).order('RANDOM()') }
  scope :non_email,   -> { where.not(email: nil) }

  class << self
    private

    def pending_cards_notification
      pending_users = User.non_email.joins(:cards).pending
      emails        = pending_users.pluck(:email)
      CardsMailerJob.perform_later(emails)
    end
  end
end
