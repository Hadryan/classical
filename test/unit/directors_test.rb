require 'test_helper'

class DirectorsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_director_create
    product = Director.new
    assert !product.valid?
    assert product.errors.invalid?(:title)
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:price)
    assert product.errors.invalid?(:image_url)
  end
end
