class Filling < ApplicationRecord
  include Userable
  
  belongs_to :block
  validates :block_id, presence: { message: 'Выберите колоду из выпадающего списка.' }
end
