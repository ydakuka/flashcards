class CardsMailerJob < ApplicationJob
  queue_as :default

  def perform(emails)
    CardsMailer.pending_cards_notification(emails).deliver_now
  end
end
