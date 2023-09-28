require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.create(name: 'Name LastName') }

  def attr_mod(mod, obj: user)
    obj[mod.keys.first] = mod.values.first
    obj
  end

  describe ".new 'User' is valid only:" do
    it '- with valid attributes' do
      expect(user).to be_valid
      expect(attr_mod({ name: nil })).to_not be_valid
    end
  end

  describe '* attributes' do
    describe '.name validations' do
      it '- must be provided' do
        expect(attr_mod({ name: nil })).to_not be_valid
      end

      it '- must be at least 5 characters' do
        expect(attr_mod({ name: 'a' * 4 })).to_not be_valid
      end

      it '- must be 50 characters max' do
        expect(attr_mod({ name: 'a' * 52 })).to_not be_valid
      end
    end

    describe '.posts_counter validations' do
      it '- is an <Integer>' do
        expect(attr_mod({ posts_counter: 'a' })).to_not be_valid
        expect(attr_mod({ posts_counter: nil })).to_not be_valid
        expect(attr_mod({ posts_counter: true })).to_not be_valid
        expect(attr_mod({ posts_counter: 10 })).to be_valid
      end

      it '- is greater than or equal to zero' do
        expect(attr_mod({ posts_counter: -1 })).to_not be_valid
        expect(attr_mod({ posts_counter: -10 })).to_not be_valid
        expect(attr_mod({ posts_counter: 0 })).to be_valid
        expect(attr_mod({ posts_counter: 5 })).to be_valid
      end
    end
  end

  describe '* methods' do
    describe '#most_recent_posts' do
      context "- when a 'User' is created" do
        it "> should return zero 'posts'" do
          expect(user.most_recent_posts).to be_empty
        end
      end

      context "- when a 'User' has several 'posts'" do
        it "> should return the three most recent 'posts'" do
          posts = []
          %i[1 2 3 4 5 6 7 8].each do |post_number|
            time = Time.now - (2.hour * post_number.to_s.to_i)
            posts << Post.create(author: user, title: "Post ##{post_number}", text: "Text for Post ##{post_number}",
                                 created_at: time, updated_at: time)
          end

          post1, post2, post3, = posts
          expect(user.most_recent_posts).to eq([post1, post2, post3])
        end
      end
    end
  end

  describe '* associations' do
    context '.posts' do
      it "=> responds for the has many 'posts'" do
        association = described_class.reflect_on_association(:posts)
        expect(association.macro).to eq(:has_many)
      end
    end

    context '.comments' do
      it "=> responds for the has many 'comments'" do
        association = described_class.reflect_on_association(:comments)
        expect(association.macro).to eq(:has_many)
      end
    end

    context '.likes' do
      it "=> responds for the has many 'likes'" do
        association = described_class.reflect_on_association(:likes)
        expect(association.macro).to eq(:has_many)
      end
    end
  end
end
