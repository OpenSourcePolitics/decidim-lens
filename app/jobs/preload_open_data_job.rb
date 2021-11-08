# frozen_string_literal: true

require "rake"
class PreloadOpenDataJob < ApplicationJob
  queue_as :scheduled

  def perform
    system "rake decidim:open_data:export"
    Rails.application.load_tasks
    task.reenable
    task.invoke
  end

  def task
    Rake::Task["decidim:open_data:export"]
  end
end
