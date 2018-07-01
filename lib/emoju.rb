require "emoju/version"
require "emoju/data"

module Emoju
  extend self

  SUPPORTED_ENCODINGS = [:softbank, :docomo, :google]

  def unify(str)
    result = softbank_to_unicode(str)
    result = google_to_unicode(result)
    docomo_to_unicode(result)
  end

  def softbank_to_unicode(str)
    convert_from(str, :softbank)
  end

  def docomo_to_unicode(str)
    convert_from(str, :docomo)
  end

  def google_to_unicode(str)
    convert_from(str, :google)
  end

  private

  def emoji_data
    @emoji_data ||= Data.new()
  end

  def convert_from(str, encoding)
    if SUPPORTED_ENCODINGS.include?(encoding)
      regexp = emoji_data.regexp_for(encoding)
      codepoint_map = emoji_data.public_send("emoji_#{encoding}_map".to_sym)

      str.gsub(regexp) do |capture|
        codepoint = capture.codepoints.map { |i| i.to_s(16).rjust(4,'0')}.join('-').upcase
        unified_codepoint = codepoint_map[codepoint]
        codpoint_to_str(unified_codepoint)
      end
    else
      fail "unsupported encoding"
    end
  end

  def codpoint_to_str(codepoint)
    codepoint.split("-").map { |c| [c.hex].pack("U") }.join
  end
end
