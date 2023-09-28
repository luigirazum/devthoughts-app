require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:author) { User.create(name: 'Post Author') }
  let(:user) { User.create(name: 'Liker') }
  let(:post) { Post.create(title: 'New test post', text: 'Test text for this new post', author:) }
  subject(:like) { described_class.create(user: author, post:) }

  def attr_mod(mod, obj: like)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  describe ".new 'Comment' is valid only:" do
    it '- with valid attributes' do
      expect(like).to be_valid
      expect(attr_mod({ user_id: nil })).to_not be_valid
      expect(attr_mod({ post_id: nil })).to_not be_valid
    end
  end
end
