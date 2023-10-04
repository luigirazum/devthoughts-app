require 'rails_helper'

# Helper methods used in the Specs
# ************************************************
# 'attr_mod' will allow you to test 'obj' with
# the 'mod' attribute passed.
def attr_mod(mod, obj: post)
  obj[mod.keys.first] = mod.values.first
  obj
end

# extract the five most recent posts
# from 'generate_test_comments
def extract_five_most_recent_comments(comments)
  comment1, comment2, comment3, comment4, comment5, = comments

  [comment1, comment2, comment3, comment4, comment5]
end

# create some comments for testing using
#  the current 'post' and generating a
#  'user' for each 'comment' created
def generate_test_comments(post: nil)
  comments = []
  %i[1 2 3 4 5 6 7 8].each do |comment_number|
    time = Time.now - (2.hour * comment_number.to_s.to_i)
    user = User.create(name: "User ##{comment_number} Name")
    comments << Comment.create(user:, post:, text: "Text for Comment ##{comment_number}", created_at: time,
                               updated_at: time)
  end

  comments
end

# Start of the Specs for 'Post' model
RSpec.describe Post, :models, type: :model do
  let!(:user) { User.create(name: 'Post Author') }
  let!(:post) { described_class.new(title: 'New test post', text: 'Test text for this new post', author: user) }

  before { post.save }

  describe ".new 'Post' is valid only:", :valid do
    it '- with valid attributes' do
      expect(post).to be_valid
      expect(attr_mod({ title: nil })).to_not be_valid
      expect(attr_mod({ author_id: nil })).to_not be_valid
      expect(attr_mod({ likes_counter: nil })).to_not be_valid
      expect(attr_mod({ comments_counter: nil })).to_not be_valid
    end
  end

  describe '* attributes', :validations do
    describe '.title validations' do
      it '- must be provided' do
        expect(attr_mod({ title: nil })).to_not be_valid
      end

      it "- can't exceed 250 characters" do
        expect(attr_mod({ title: 'a' * 251 })).to_not be_valid
        expect(attr_mod({ title: 'a' * 250 })).to be_valid
        expect(attr_mod({ title: 'a' * 5 })).to be_valid
      end
    end

    describe '.comments_counter validations' do
      it '- is an <Integer>' do
        expect(attr_mod({ comments_counter: 'a' })).to_not be_valid
        expect(attr_mod({ comments_counter: nil })).to_not be_valid
        expect(attr_mod({ comments_counter: true })).to_not be_valid
        expect(attr_mod({ comments_counter: 10 })).to be_valid
      end

      it '- is greater than or equal to zero' do
        expect(attr_mod({ comments_counter: -1 })).to_not be_valid
        expect(attr_mod({ comments_counter: -10 })).to_not be_valid
        expect(attr_mod({ comments_counter: 0 })).to be_valid
        expect(attr_mod({ comments_counter: 5 })).to be_valid
      end
    end

    describe '.likes_counter validations' do
      it '- is an <Integer>' do
        expect(attr_mod({ likes_counter: 'a' })).to_not be_valid
        expect(attr_mod({ likes_counter: nil })).to_not be_valid
        expect(attr_mod({ likes_counter: true })).to_not be_valid
        expect(attr_mod({ likes_counter: 10 })).to be_valid
      end

      it '- is greater than or equal to zero' do
        expect(attr_mod({ likes_counter: -1 })).to_not be_valid
        expect(attr_mod({ likes_counter: -10 })).to_not be_valid
        expect(attr_mod({ likes_counter: 0 })).to be_valid
        expect(attr_mod({ likes_counter: 5 })).to be_valid
      end
    end
  end

  describe '* methods', :methods do
    describe '#most_recent_comments' do
      context "- when a 'Post' is created" do
        it "> should return zero 'comments'" do
          expect(post.most_recent_comments).to be_empty
        end
      end

      context "- when a 'Post' has several 'comments'" do
        it "> should return the five most recent 'comments'" do
          comments = generate_test_comments(post:)
          expect(post.most_recent_comments).to eq(extract_five_most_recent_comments(comments))
        end
      end
    end

    describe '#update_posts_counter' do
      context "- when 'called'" do
        it "> should refresh the 'posts_counter'" do
          user.posts_counter = nil
          expect(user.posts_counter).to be_nil
          post.update_posts_counter
          expect(user.posts_counter).to eq(1)
        end
      end

      context "- when a 'Post' is created" do
        it "> should refresh 'posts_counter' increased by 1" do
          Post.create(author: post.author, title: 'An extra Post', text: 'Another Post')
          expect(user.posts_counter).to eq(post.author.posts_counter)
        end
      end

      context "- when a 'Post' is deleted" do
        it "> should refresh 'posts_counter' decreased by 1" do
          Post.destroy(post.id)
          expect(user.posts_counter).to eq(post.author.posts_counter)
        end
      end
    end
  end

  describe '* associations', :associations do
    context '.author' do
      it "=> responds for belongs to an 'author'" do
        association = described_class.reflect_on_association(:author)
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context '.comments' do
      it "=> responds for has many 'comments'" do
        association = described_class.reflect_on_association(:comments)
        expect(association.macro).to eq(:has_many)
      end
    end

    context '.likes' do
      it "=> responds for has many 'likes'" do
        association = described_class.reflect_on_association(:likes)
        expect(association.macro).to eq(:has_many)
      end
    end
  end
end
