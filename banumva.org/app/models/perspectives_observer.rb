class PerspectivesObserver < ActiveRecord::Observer

  observe :perspectives

  def before_create(perspectives)
    perspectives.p_uuid = get_random
  end

  def after_create(perspectives)
    recipient = User.find(perspectives.user_id).email
    subject = "Thanks for offering your perspective"
    message = ""
    body = {:user_alias => User.find(perspectives.user_id).user_alias,
      :record_text => perspectives[:record_text],
      :created_at => perspectives[:created_at]}
    return (Notifier.comments_received(recipient, subject, message, body).deliver)
  end

  def get_random
    length = 36
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a

    @password = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
    @password
  end
end

