require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Post Author') }
  subject(:post) { described_class.create(title: 'New test post', text: 'Test text for this new post', author: user) }

  def attr_mod(mod, obj: post)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  describe ".new 'Post' is valid only:" do
    it '- with valid attributes' do
      expect(post).to be_valid
      expect(attr_mod({ title: nil })).to_not be_valid
      expect(attr_mod({ author_id: nil })).to_not be_valid
      expect(attr_mod({ likes_counter: nil })).to_not be_valid
      expect(attr_mod({ comments_counter: nil })).to_not be_valid
    end
  end
end
