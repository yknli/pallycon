module Pallycon
  class Configuration
    class SiteIDNotSet < StandardError; end
    class SiteKeyNotSet < StandardError; end
    class SiteAccessKeyNotSet < StandardError; end

    attr_accessor :site_id
    attr_accessor :site_key
    attr_accessor :site_access_key

    def site_id=(site_id)
      raise SiteIDNotSet, "Please set PALLYCON site id." if site_id.to_s.strip.empty?

      @site_id = site_id
    end

    def site_key=(site_key)
      raise SiteKeyNotSet, "Please set PALLYCON site key." if site_key.to_s.strip.empty?

      @site_key = site_key
    end

    def site_access_key=(site_access_key)
      raise SiteAccessKeyNotSet, "Please set PALLYCON site access key." if site_access_key.to_s.strip.empty?

      @site_access_key = site_access_key
    end

  end
end