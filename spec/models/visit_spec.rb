require 'rails_helper'

RSpec.describe Visit, type: :model do
  let(:v) { build(:visit) }

  describe "ActiveModel validations" do
    # basic validations
    [:date_of_service, :webptvisitid].each do |attr|
      it { expect(v).to validate_presence_of(attr) }
    end

    it { expect(v).to validate_uniqueness_of(:webptvisitid).case_insensitive }
    it { expect(v).to validate_numericality_of(:webptvisitid) }
  end

  describe "ActiveRecord associations" do
    it { expect(v).to belong_to(:patient) }
  end
end
