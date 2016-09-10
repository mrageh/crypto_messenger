desc "Send text message with latest bitcoin price"
task :send_text => :environment do
  TextNotificationJob.perform_later
end
