require 'jwt'

class JsonWebToken

  def self.secret_key
    Rails.application.credentials.jwt_secret
  end

  def self.encode_token(payload)
    payload[:exp] = 4.hours.from_now.to_i
    JWT.encode(payload, secret_key, 'HS256')
  end

  def self.decode_token(token)
    JWT.decode(token, secret_key, true, algorithm: 'HS256')
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end

end

