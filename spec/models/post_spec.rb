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

  describe '* attributes' do
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

  describe '* methods' do
    describe '#most_recent_comments' do
      context "- when a 'Post' is created" do
        it "> should return zero 'comments'" do
          expect(post.most_recent_comments).to be_empty
        end
      end

      context "- when a 'Post' has several 'comments'" do
        it "> should return the five most recent 'comments'" do
          comments = []
          %i[1 2 3 4 5 6 7 8].each do |comment_number|
            time = Time.now - (2.hour * comment_number.to_s.to_i)
            user = User.create(name: "User ##{comment_number} Name")
            comments << Comment.create(user:, post:, text: "Text for Comment ##{comment_number}", created_at: time, updated_at: time)
          end

          comment1, comment2, comment3, comment4, comment5, = comments
          expect(post.most_recent_comments).to eq([comment1, comment2, comment3, comment4, comment5])
        end
      end
    end
  end
end
