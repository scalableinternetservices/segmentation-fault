require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'create too few parameters' do
    post = Post.new name: 'Good'
    assert post.invalid?

    post = Post.new name: 'Good' , description: 'This is a description'
    assert post.invalid?

    post = Post.new name: 'Good' , description: 'This is a description' , price: 100.0
    assert post.invalid?

    post = Post.new name: 'Good' , description: 'This is a description' , price: 100.0, categories: 'Mansion'
    assert post.valid?
  end
  test 'invalid categories' do
    post = Post.new name: 'Good' , description: 'This is a description' , price: 100.0, categories: ''
    assert post.invalid?

    post = Post.new name: 'Good' , description: 'This is a description' , price: 100.0, categories: 'Mansion'
    assert post.valid?
  end
end