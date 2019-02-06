namespace :schedule do
  desc 'download resources'
  task download: :environment do
    Crawler::Sync.new.run
  end
end
