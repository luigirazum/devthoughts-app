require 'rails_helper'

# Start of the Specs for 'Comment' model
RSpec.describe Comment, :models, type: :model do
  let!(:user) { User.create(name: 'Post Author') }
  let!(:commenter) { User.create(name: 'Commenter') }
  let!(:post) { Post.create(title: 'New test post', text: 'Test text for this new post', author: user) }
  let!(:comment) { described_class.new(text: 'Test text for this new comment', user: commenter, post:) }

  # Helper method used in the Specs
  # ************************************************
  # 'attr_mod' will allow you to test 'obj' with
  # the 'mod' attribute passed.
  def attr_mod(mod, obj: comment)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  before { comment.save }

  describe ".new 'Comment' is valid only:", :valid do
    it '- with valid attributes' do
      expect(comment).to be_valid
      expect(attr_mod({ text: nil })).to_not be_valid
      expect(attr_mod({ user_id: nil })).to_not be_valid
      expect(attr_mod({ post_id: nil })).to_not be_valid
    end
  end

  describe '* attributes', :validations do
    describe '.text validations' do
      it '- must be provided' do
        expect(attr_mod({ text: nil })).to_not be_valid
      end
    end
  end

  describe '* methods', :methods do
    describe '#update_comments_counter' do
      context "- when 'called'" do
        it "> should refresh the 'comments_counter'" do
          post.comments_counter = nil
          expect(post.comments_counter).to be_nil
          comment.update_comments_counter
          expect(post.comments_counter).to eq(1)
        end
      end

      context "- when a 'Comment' is created" do
        it "> should refresh 'comments_counter' increased by 1" do
          Comment.create(user: commenter, post: comment.post, text: 'Another Comment')
          expect(post.comments_counter).to eq(comment.post.comments_counter)
        end
      end

      context "- when a 'Comment' is deleted" do
        it "> should refresh 'comments_counter' decreased by 1" do
          Comment.destroy(comment.id)
          expect(post.comments_counter).to eq(comment.post.comments_counter)
        end
      end
    end
  end

  describe '* associations', :associations do
    context '.user' do
      it "=> responds for belongs to an 'user'" do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context '.post' do
      it "=> responds for belongs to a 'post'" do
        association = described_class.reflect_on_association(:post)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end
