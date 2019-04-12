class JwtService
  def self.encode(payload:)
    JWT.encode(payload, self.secret)
  end

  def self.decode(token:)
    JWT.decode(token, self.secret).first
  end
  def self.secret
    # Change this to whatever you like
    # but keep it a secret!
    ENV['JWT_SECRET_KEY']
  end
end

