class SendAdminReportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # @idea = Idea.all
    # AdminMailer...
  end
end

# SendAdminReportJob.perform_later()
