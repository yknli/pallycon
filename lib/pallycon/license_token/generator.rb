module Pallycon
  module LicenseToken
    class Generator
      class EncKeyIsEmpty < StandardError; end

      class << self
        def generate(attrs=Attributes.new, enc_key='')
          raise EncKeyIsEmpty, "Please specify your content encryption key." if enc_key.to_s.strip.empty?

          policy = Policy.new(enc_key, attrs.content_id)

          token = {
            drm_type: attrs.drm_type,
            site_id:  attrs.site_id,
            user_id:  attrs.user_id,
            cid:      attrs.content_id,
            policy:   policy.encrypt,
            timestamp: policy.timestamp,
            hash: hash(attrs, policy),
            key_rotation: false
          }
          Base64.strict_encode64(token.to_json)
        end

        private

        def hash(attrs, policy)
          s = attrs.site_access_key + attrs.drm_type + attrs.site_id + attrs.user_id + attrs.content_id + policy.encrypt + policy.timestamp
          sha256 = OpenSSL::Digest.new('sha256', s)
          Base64.strict_encode64(sha256.digest)
        end
      end

    end
  end
end