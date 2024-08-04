module Pallycon
  module LicenseToken
    class Policy

      MAX_STREAM_PER_USER = 1

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

    end
  end
end