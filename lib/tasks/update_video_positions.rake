namespace :video do
  desc:'Update video positions with nil value'
  task :update_nil_positions => :environment do
    Video.where(position: nil).each { |video| video.update_position(0) }
  end
end
