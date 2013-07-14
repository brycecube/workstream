require "test/unit"

require "util.rb"

class UtilTest < Test::Unit::TestCase
  def test_is_file_name
    
    #positives
    
    file = 'test.mp3'
    assert( is_file_safe( file ), "#{file} should be safe")
    
    file = 'AZ1z09-123_.mp3'
    assert( is_file_safe( file ), "#{file} should be safe")

    file = 'AZ1z09-123_.mp3'
    assert( is_file_safe( file, 'mp3' ), "#{file} should be safe as a mp3")

    # negatives

    file = '../test.png'
    assert( !is_file_safe( file ), "#{file} should not be safe")

    file = '/usr/test.png'
    assert( !is_file_safe( file ), "#{file} should not be safe")

    file = 'test.test'
    assert( !is_file_safe( file, 'png' ), "#{file} should not be safe as a png")

    file = 'mp3'
    assert( !is_file_safe( file, 'mp3' ), "#{file} should not be safe as a mp3")
    
    file = '.mp3'
    assert( !is_file_safe( file, 'mp3' ), "#{file} should not be safe as a mp3")

  end
end

