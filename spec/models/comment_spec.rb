require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Post Author') }
  let(:commenter) { User.create(name: 'Commenter') }
  let(:post) { Post.create(title: 'New test post', text: 'Test text for this new post', author: user) }
  subject(:comment) { described_class.create(text: 'Test text for this new comment', user: commenter, post:) }

  def attr_mod(mod, obj: comment)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  describe ".new 'Comment' is valid only:" do
    it '- with valid attributes' do
      expect(comment).to be_valid
      expect(attr_mod({ text: nil })).to_not be_valid
      expect(attr_mod({ user_id: nil })).to_not be_valid
      expect(attr_mod({ post_id: nil })).to_not be_valid
    end
  end
end
