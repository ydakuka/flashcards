class Authentication < ApplicationRecord
  include Userable
  validates :provider, :uid, presence: true
end
