require 'rails_helper'

RSpec.describe CardsMailerJob, type: :job do
  describe "#perform" do
    it "calls on the CardsMailer" do
      user = double("user", id: 1)
      allow(User).to receive(:find).and_return(user)
      allow(CardsMailer).to receive_message_chain(:pending_cards_notification, :deliver_now)
      described_class.new.perform(user.id)
      expect(CardsMailer).to have_received(:pending_cards_notification)
    end
  end

  describe ".perform_later" do
    it "adds the job to the queue :default" do
      allow(CardsMailer).to receive_message_chain(:pending_cards_notification, :deliver_now)
      described_class.perform_later(1)
      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end

  describe "asdb" do
    subject(:job) { CardsMailerJob }

    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it 'is in default queue' do
      expect(job.new.queue_name).to eq('default')
    end

    it "when run 0 job" do
      expect(enqueued_jobs.size).to eq(0)
    end

    it "when run 1 job" do
      job.perform_later(1, 1)
      expect(job).to have_been_enqueued.on_queue("default")
      expect(enqueued_jobs.size).to eq(1)
    end

    it "when run 5 jobs" do
      5.times { |i| job.perform_later(i, i) }
      expect(enqueued_jobs.size).to eq(5)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end
end
