require 'rails_helper'

RSpec.describe RemoteFillingJob, type: :job do
  subject(:job) { RemoteFillingJob }

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
    expect(job).to have_been_enqueued.with(1, 1).on_queue("default")
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
