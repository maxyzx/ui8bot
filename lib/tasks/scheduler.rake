namespace :schedule do
  desc 'download resources'
  task download: :environment do
    Crawler::Sync.new.run
  end

  desc 'fetcher data'
  task fetch: :environment do
    Crawler::Fetcher.new.run
  end
end
