class UserDecorator < ApplicationDecorator
  decorates :user

  def title
    "@#{model.username}'s Dreets"
  end

  def display_name
    if full_name.present?
      h.link_to "#{full_name} +#{model.username}", model, class: 'display_name_link'
    else
      h.link_to "@#{model.username}", model, class: 'display_name_link'
    end
  end
  
  def full_name
    if model.first_name? && model.last_name?
      model.first_name + " " + model.last_name
    elsif model.first_name?
      model.first_name
    elsif model.last_name?
      model.last_name
    end
  end

  def avatar
    h.link_to model, class: 'avatar_link' do
      h.image_tag gravatar_url, alt: model.username, title: "#{model.username}: #{model.tagline}", class: "avatar_image"
    end
  end

  def tagline
    if model.tagline?
      h.content_tag 'div', model.tagline, class: 'tagline'
    end
  end

  def twitter_link
    if model.twitter?
      h.content_tag 'div', class: 'twitter_link' do
        h.link_to "T: @#{model.twitter.downcase}", "http://twitter.com/#!/#{model.twitter.downcase}", target: '_blank'
      end
    end
  end
  
  def facebook_link
    if model.facebook?
      h.content_tag 'div', class: 'facebook_link' do
        h.link_to "F: #{model.facebook.downcase}", "http://facebook.com/#{model.facebook.downcase}", target: '_blank'
      end
    end
  end
  
  def website_link
    if model.website?
      h.content_tag 'div', class: 'website_link' do
        h.link_to "W: #{model.website.downcase}", fix_url(model.website), target: '_blank'
      end
    end
  end

  def signed_in?
    model.id?
  end
  
  def session_control
    if signed_in?
      h.link_to 'Sign Out', h.sign_out_path
    else
      h.link_to 'Sign In', h.sign_in_path
    end
  end

  def sidebar
    if signed_in?
      h.render 'shared/signed_in_sidebar'
    else
      h.render 'shared/signed_out_sidebar'
    end
  end
  
  def dreets_count
    stat_count(model.posts.size, 'Dreet', h.user_path(model))
  end
  
  def followings_count
    stat_count(model.followings.size, 'Following', h.followings_user_path(model))
  end
  
  def followers_count
    stat_count(model.followers.size, 'Follower', h.followers_user_path(model))
  end
  
  def dreets
    PostDecorator.decorate(model.posts.recent)
  end
  
  def followers
    UserDecorator.decorate(model.followers)
  end
  
  def followings
    UserDecorator.decorate(model.followings)
  end

  def command_for_user(user)
    if signed_in?
      if model == user.model
        h.link_to 'Edit', h.edit_user_path(model), class: 'btn primary', id: 'edit_user_button'
      elsif model.following? user.model.id
        h.link_to 'Following', h.user_relationship_path(user.username,0), method: :delete, remote: true, class: 'btn success', id: 'unfollow_button'
      else
        h.link_to 'Follow', h.user_relationships_path(user.username), method: :post, remote: true, class: 'btn primary', id: 'follow_button'
      end
    end
  end

  def to_i
    model.to_i
  end

  private
  
  def fix_url(url)
    if url.downcase.start_with? "http"
      url.downcase
    else
      "http://#{url.downcase}"
    end
  end
  
  def stat_count(stat_value, stat_name, destination)
    if stat_value > 0
      h.link_to destination, class: 'stat_link' do
        h.content_tag('h2', stat_value) +
        if stat_value == 1 then h.content_tag('h3', stat_name) else h.content_tag('h3', stat_name.pluralize) end
      end
    else
      h.content_tag('h2', 'No') +
      h.content_tag('h3', stat_name.pluralize)
    end
  end
  
  def gravatar_url
    "http://www.gravatar.com/avatar/" + gravatar_hash
  end
  
  def gravatar_hash
    Digest::MD5.hexdigest(model.email.strip.downcase)
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #   
  #   Or, optionally enable "lazy helpers" by calling this method:
  #     lazy_helpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #   
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"), 
  #                   :class => 'timestamp'
  #   end
end