require 'super_memo'

module Distancable
  extend ActiveSupport::Concern

  included do
    validate :texts_are_not_equal
    before_validation :set_review_date_as_now, on: :create
    validates :original_text, :translated_text, :review_date,
              presence: { message: 'Необходимо заполнить поле.' }
    validates :interval, :repeat, :efactor, :quality, :attempt, presence: true
  end

  def check_translation(user_translation)
    distance = Levenshtein.distance(full_downcase(translated_text),
                                    full_downcase(user_translation))

    if distance <= 1
      check_distance(1, true, distance, set_interval_date)
    else
      check_distance(set_min_attempt, false, distance)
    end
  end

  protected

  def texts_are_not_equal
    if full_downcase(original_text) == full_downcase(translated_text)
      errors.add(:original_text, 'Вводимые значения должны отличаться.')
    end
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end

  def set_review_date_as_now
    self.review_date = Time.now
  end

  def set_min_attempt
    [attempt + 1, 5].min
  end

  private

  def check_distance(attempt_value, state, distance, review_date=Time.new(0))
    sm_hash = SuperMemo.algorithm(interval, repeat, efactor, attempt, distance)
    sm_hash.merge!({ review_date: review_date, attempt: attempt_value })
    update(sm_hash)
    { state: state, distance: distance }
  end

  def set_interval_date
    Time.now + interval.to_i.days
  end
end
