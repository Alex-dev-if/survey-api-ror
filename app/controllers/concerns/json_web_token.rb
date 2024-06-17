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
    begin
      JWT.decode(token, secret_key, true, algorithm: 'HS256')
    rescue JWT::ExpiredSignature
      raise GraphQL::ExecutionError, "Session expired"
    rescue JWT::VerificationError, JWT::DecodeError => e
      raise GraphQL::ExecutionError, "Token verification failed: #{e.message}"
    end
  end

end

