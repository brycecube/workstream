require "test/unit"
require 'YamlConfig'

class YamlConfigTest < Test::Unit::TestCase
  
  def testMergeSimple
    config = { :p1 => 'val1', :p2 => 'val2' }
    override = { :p2 => 'val1', :p3 => 'val1' }
    
    yc = YamlConfig.new
    yc.merge( config, override )
    
    assert_equal( 'val1', config[:p1] )
    assert_equal( 'val1', config[:p2] )
    assert_equal( 'val1', config[:p3] )
  end
  
  def testMergeDeep
    config = { :p1 => 'val1', :p2 => { :p21 => 'val1', :p22 => 'val1' } }
    override = { :p2 => { :p21 => 'val2' }, :p3 => 'val2' }
    
    yc = YamlConfig.new
    yc.merge( config, override )
    
    assert_equal( 'val1', config[:p1] )
    assert_equal( 'val2', config[:p2][:p21] )
    assert_equal( 'val1', config[:p2][:p22] )
    assert_equal( 'val2', config[:p3] )
  end
  
  def testMergeFlatAgainstDeep
    # flat merge flat
    config = { :p1 => 'val1', :p2 => 'val1' }
    override = { :p2 => { :p21 => 'val2' }, :p3 => 'val2' }
    
    yc = YamlConfig.new
    yc.merge( config, override )
    
    assert_equal( 'val1', config[:p1] )
    assert_equal( 'val2', config[:p2][:p21] )
    assert_equal( 'val2', config[:p3] )
  end

  def testMergeDeepAgainstFlat
    config = { :p1 => 'val1', :p2 => { :p21 => 'val1', :p22 => 'val1' } }
    override = { :p2 => 'val2', :p3 => 'val2' }
    
    yc = YamlConfig.new
    yc.merge( config, override )
    
    assert_equal( 'val1', config[:p1] )
    assert_equal( 'val2', config[:p2] )
    assert_equal( 'val2', config[:p3] )
  end
  
end

