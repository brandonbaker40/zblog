require 'rails_helper'

RSpec.describe User, type: :model do
  let(:u) { build(:user) }

  describe "ActiveModel validations" do
    # basic validations
    [:email].each do |attr|
      it { expect(u).to validate_presence_of(attr) }
    end
  end
end
