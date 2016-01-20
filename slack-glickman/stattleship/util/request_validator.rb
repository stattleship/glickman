module Stattleship
  module Util
    class RequestValidator
      def initialize(auth_token: nil)
        @auth_token = auth_token
        raise ArgumentError, 'Auth token is required' if @auth_token.nil?
      end

      def signature(params)
        data = params.values.map { |value| value.gsub(/\s+/, '') }.sort.join
        digest = OpenSSL::Digest.new('sha1')
        Base64.encode64(OpenSSL::HMAC.digest(digest, @auth_token, data)).strip
      end
    end
  end
end
