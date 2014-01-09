class SignaturesObserver < ActiveRecord::Observer

  observe :signatures

  def before_create(signatures)
    signatures.uuid = get_random
  end

  def after_create(signatures)
    recipient = User.find(signatures.user_id).email
    subject = "Thanks for signing the 'No Uranium Mining in Virginia!' petition"
    message = ""
    body = {:signer_alias => signatures[:signer_alias],
      :comments => signatures[:comments],
      :created_at => signatures[:created_at]}
    return (Notifier.signature_comments(recipient, subject, message, body).deliver)
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
