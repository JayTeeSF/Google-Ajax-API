require 'test_helper'

class Google::AjaxApiTest < Test::Unit::TestCase
  def test_scriptaculous_urls
    fw = 'scriptaculous'
    version = '1.8.2'
    fw_filename = 'effects'
    options = {:cached => true, :env => :production}
    _skip_cache = Google::AjaxApi.skip_gajax_cache?(options)
    ext = ".js"

    expected = "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"
    got = Google::AjaxApi.js_url_or_filename(fw, version, fw_filename, _skip_cache)
    assert got == expected

    fw_filename = 'dragdrop'
    expected = "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"
    got = Google::AjaxApi.js_url_or_filename(fw, version, fw_filename, _skip_cache)
    assert got == expected

    fw_filename = 'controls'
    expected = "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"
    got = Google::AjaxApi.js_url_or_filename(fw, version, fw_filename, _skip_cache)
    assert got == expected
  end

  def test_jquery_cached
    expected = ["jquery"]

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :development_env)
    assert got == expected

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :test_env)
    assert got == expected
  end

  def test_jquery_and_ui_cached
    expected = ["jquery", "jquery-ui"]

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2','jqueryui-1.7.1', :cached, :development_env)
    assert got == expected

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2','jqueryui-1.7.1', :cached, :test_env)
    assert got == expected
  end

  def test_jquery_notcached
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]
    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :production_env)
    assert got == expected

    got = Google::AjaxApi.js_url_or_filename('jquery', '1.3.2')
    assert got == expected.first
  end

  def test_jquery_and_ui_notcached
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]
    fw, version, fw_filename, ext = 'jqueryui', '1.7.1', 'jquery-ui', '.js'
    expected << "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', 'jqueryui-1.7.1', :production_env)
    assert got == expected
  end

  def test_jquery_cache_ignored
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]
    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :production_env)
    assert got == expected
  end

  def test_jquery_and_ui_cache_ignored
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]
    fw, version, fw_filename, ext = 'jqueryui', '1.7.1', 'jquery-ui', '.js'
    expected << "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', 'jqueryui-1.7.1', :cached, :production_env)
    assert got == expected
  end

  def test_jquery_minified_cached
    expected = ["jquery"]

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :minified, :development_env)
    assert got == expected

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :minified, :test_env)
    assert got == expected
  end

  def test_jquery_minified_cache_ignored
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.min.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', :cached, :minified, :production_env)
    assert got == expected

    got = Google::AjaxApi.js_url_or_filename('jquery', '1.3.2', 'jquery', true, :minified => true)
    assert got == expected.first
  end

  def test_jquery_and_ui_minified_cache_ignored
    fw, version, fw_filename, ext = 'jquery', '1.3.2', 'jquery', '.min.js'
    expected = ["#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"]
    fw, version, fw_filename, ext = 'jqueryui', '1.7.1', 'jquery-ui', '.min.js'
    expected << "#{Google::AjaxApi::BASE_URL}#{fw}/#{version}/#{fw_filename}#{ext}"

    got = Google::AjaxApi.js_urls_or_filenames('jquery-1.3.2', 'jqueryui-1.7.1', :cached, :minified, :production_env)
    assert got == expected
  end
end
