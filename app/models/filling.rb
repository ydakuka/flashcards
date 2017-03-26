class Filling < ApplicationRecord
  include Userable
  
  belongs_to :block
  validates :block_id, presence: { message: 'Выберите колоду из выпадающего списка.' }
  validates :original_selector, :translated_selector, :url, presence: true
  validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
end
