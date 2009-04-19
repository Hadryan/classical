require 'test_helper'

class ComposerTest < ActiveSupport::TestCase
  fixtures :composers
  
  def test_full_name
    assert_equal 'Pepe', full_name('Pepe', nil), 'nil last_name'
    assert_equal 'Pepe', full_name('Pepe', ''), 'blank last_name'
    assert_equal 'Gonzalez', full_name('', 'Gonzalez'), 'blank first_name'
    assert_equal 'Gonzalez', full_name(nil, 'Gonzalez'), 'nil first_name'
    assert_equal 'Gonzalez, Pepe', full_name('Pepe', 'Gonzalez'), 'Gonzalez last_name'
  end
  
  def test_find_by_full_name
    composer = Composer.new(:first_name => 'Pepe', :last_name => 'Gonzalez')
    composer.save
    
    assert_equal 1, Composer.find_by_full_name(composer.full_name).length, 'Find 1 results'
            
    assert_equal 0, Composer.find_by_full_name('Gonzalez, Pe').length, 'Find 0 results with wrong name'
    assert_equal 0, Composer.find_by_full_name('Gonzale, Pepe').length, 'Find 0 results with wrong last_name'
    assert_equal 0, Composer.find_by_full_name('Gonzalez').length, 'Find 0 results without first_name'
  end
  
  def test_find_by_full_name_with_empty_name
    composer = Composer.new(:first_name => '', :last_name => 'Perez')
    composer.save
    composer1 = Composer.new(:last_name => 'Perez')
    composer1.save
        
    assert_equal 1, Composer.find_by_full_name(composer1.full_name).length, 'With nil First_name'
    assert_equal 1, Composer.find_by_full_name(composer.full_name).length, 'With empty First_name'
  end
  
  def new_composer(first_name, last_name)
    Composer.new(:first_name => first_name, :last_name => last_name)
  end
  
  def full_name(first_name, last_name)
    Composer.new(:first_name => first_name, :last_name => last_name).full_name
  end
end

