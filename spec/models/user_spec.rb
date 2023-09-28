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

    end
  end
end
