class TextNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Notifier.new.notify
  end
end
