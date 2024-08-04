module Pallycon
  module LicenseToken
    class Attributes

      attr_accessor :site_id
      attr_accessor :site_access_key

      attr_accessor :drm_type
      attr_accessor :user_id
      attr_accessor :content_id

      def initialize(attrs={ drm_type: Pallycon::Drm::TYPES[:playready], user_id: '', content_id: '' })
        @site_id         = Pallycon.configuration.site_id
        @site_access_key = Pallycon.configuration.site_access_key

        @user_id    = attrs[:user_id]
        @content_id = attrs[:content_id]

        @drm_type   = attrs[:drm_type]
      end

    end
  end
end