module Pallycon
  module LicenseToken
    class Policy
      IV = '0123456789abcdef' # defined by PALLYCON

      MAX_STREAM_PER_USER = 1
      LICENSE_DURATION    = 600 # seconds

      attr_accessor :body

      # TODO: should write a policy generator to create policy by different cases
      def initialize(enc_key, content_id)
        @body = {
          policy_version: 2,
          playback_policy: {
            persistent: false,
            expire_date: expire_date,
            allowed_track_types: "SD_HD",
            max_stream_per_user: MAX_STREAM_PER_USER
          },
          security_policy: [
            {
              track_type: "ALL",
              widevine: {
                security_level: 1,
                required_hdcp_version: "HDCP_NONE",
                required_cgms_flags: "CGMS_NONE",
                disable_analog_output: false,
                hdcp_srm_rule: "HDCP_SRM_RULE_NONE",
                override_device_revocation: false,
                enable_license_cipher: false
              },
              playready: {
                security_level: 150,
                digital_video_protection_level: 100,
                analog_video_protection_level: 100,
                digital_audio_protection_level: 100,
                require_hdcp_type_1: false
              },
            }
          ],
          external_key: {
            mpeg_cenc: [
              {
                track_type: "ALL",
                key_id: content_id,
                key: enc_key
              }
            ]
          }
        }
      end

      def encrypt
        @encrypt ||= Base64.strict_encode64(aes256_cbc_encrypt(Pallycon.configuration.site_key, self.body.to_json, IV))
      end

      # TODO: should be defined in utils packages
      def aes256_cbc_encrypt(key, data, iv)
        key = Digest::SHA256.digest(key) if(key.kind_of?(String) && 32 != key.bytesize)
        iv = Digest::MD5.digest(iv) if(iv.kind_of?(String) && 16 != iv.bytesize)
        aes = OpenSSL::Cipher.new('AES-256-CBC')
        aes.encrypt
        aes.key = key
        aes.iv = iv
        aes.update(data) + aes.final
      end

      def current_time
        @current_time ||= Time.now.utc
      end

      def timestamp
        @timestamp ||= current_time.strftime('%Y-%m-%dT%TZ')
      end

      def expire_date
        @expire_date ||= (current_time + LICENSE_DURATION).strftime('%Y-%m-%dT%TZ')
      end

    end
  end
end