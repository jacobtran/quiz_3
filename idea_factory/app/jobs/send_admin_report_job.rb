class SendAdminReportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    # @idea = Idea.all
    # AdminMailer...
  end
end

# SendAdminReportJob.perform_later()
