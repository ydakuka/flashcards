class Block < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :fillings, dependent: :destroy
  belongs_to :user

  validates :title, presence: { message: 'Необходимо заполнить поле.' }

  def current?
    id == user.current_block_id
  end
end
