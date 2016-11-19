class NewPostNotifyJob < ApplicationJob
  queue_as :default

  def perform(post)
    User.approved.each do |user|
      UserMailer.new_post_email(user, post).deliver_now
    end  
  end
end
