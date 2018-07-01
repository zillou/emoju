require "json"

module Emoju
  class Data
    GEM_ROOT = File.join(File.dirname(__FILE__), "../..")
    VENDOR_DATA = "data/emoji.json"

    attr_reader :emoji_softbank_map, :emoji_docomo_map, :emoji_google_map

    def initialize
      @emoji_docomo_map = {}
      @emoji_softbank_map = {}
      @emoji_google_map = {}

      raw_json = IO.read(File.join(GEM_ROOT, VENDOR_DATA))

      vendordata = JSON.parse( raw_json )

      vendordata.each do |emoji|
        @emoji_softbank_map[emoji["softbank"]] = emoji["unified"] if emoji["softbank"]
        @emoji_docomo_map[emoji["docomo"]] = emoji["unified"] if emoji["docomo"]
        @emoji_google_map[emoji["google"]] = emoji["unified"] if emoji["google"]
      end
    end

    def emoji_softbank_regexp
      regexp_for(:softbank)
    end

    def emoji_google_regexp
      regexp_for(:docomo)
    end

    def emoji_docomo_regexp
      regexp_for(:google)
    end

    def regexp_for(encoding)
      regexp = instance_variable_get("@emoji_#{encoding}_map".to_sym).keys.
        map { |codepoints| codepoint_regexp(codepoints) }.
        join("|")

      Regexp.new(regexp).freeze
    end

    def codepoint_regexp(codepoints)
      codepoints.split("-").map { |codepoint| "\\u\{#{codepoint}\}" }.join
    end
  end
end
