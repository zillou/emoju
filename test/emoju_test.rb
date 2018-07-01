require "test_helper"

class EmojuTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Emoju::VERSION
  end

  def test_unicode_emoji
    assert "🍎 + ✏️  = 🍍", ::Emoju.unify("🍎 + ✏️  = 🍍")
  end

  def test_softbank_emoji
    assert_equal "Emoji 🚀", ::Emoju.unify("Emoji \u{E10D}")
  end

  def test_docomo_emoji
    assert_equal "🍞", ::Emoju.unify("\u{E74D}")
  end

  def test_google_emoji
    assert_equal "🍞", ::Emoju.unify("\u{FE964}")
  end

  def test_multiple_code_points
    assert_equal "#️⃣", ::Emoju.unify("\u{E210}")
  end
end
