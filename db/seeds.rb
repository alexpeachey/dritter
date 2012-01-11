unless User.exists?('alex')
  @user1 = User.create(username: 'alex', password: '123', password_confirmation: '123', first_name: 'Alex', last_name: 'Peachey', email: 'alex.peachey@gmail.com', twitter: 'alex_peachey', facebook: 'alex.peachey', tagline: 'I make computers do interesting things.')
  @user2 = User.create(username: 'tekukan', password: '123', password_confirmation: '123', first_name: 'Tekukan', last_name: 'LLC', email: 'alex.peachey@tekukan.com', twitter: 'tekukan', website: 'www.tekukan.com')
  (1..20).each do |c|
    u = User.new
    u.first_name = Dritter::DreetFactory::random_first_name
    u.last_name = Dritter::DreetFactory::random_last_name
    u.username = u.first_name.downcase + c.to_s
    u.password = '123'
    u.password_confirmation = '123'
    u.email = "#{u.first_name}#{c}@#{u.last_name}.com"
    u.twitter = u.last_name.downcase + c.to_s if Dritter::DreetFactory::coin_flip
    u.facebook = u.first_name.downcase + u.last_name.downcase if Dritter::DreetFactory::coin_flip
    u.website = "www.#{u.last_name.downcase}.com" if Dritter::DreetFactory::coin_flip
    u.tagline = Dritter::DreetFactory::random_dreet if Dritter::DreetFactory::coin_flip
    u.save
    User.find_each do |i|
      u.follow!(i) if Dritter::DreetFactory::coin_flip
    end
  end
  User.find_each do |i|
    unless i == @user1
      @user1.follow!(i) if Dritter::DreetFactory::coin_flip
    end
    unless i == @user2
      @user2.follow!(i) if Dritter::DreetFactory::coin_flip
    end
  end
  (1..20).each do |t|
    User.find_each do |u|
      u.posts.create(content: Dritter::DreetFactory::random_dreet) if Dritter::DreetFactory::coin_flip
    end
  end
end