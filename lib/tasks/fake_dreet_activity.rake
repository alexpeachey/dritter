namespace :dritter do
  desc 'Generate fake dreets.'
  task :fake_dreet_activity => :environment do
    User.find_each do |u|
      if Dritter::DreetFactory::coin_flip && Dritter::DreetFactory::coin_flip
        u.posts.create(content: Dritter::DreetFactory::random_dreet)
      end
    end
  end
end