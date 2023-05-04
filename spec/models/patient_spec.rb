require 'rails_helper'

RSpec.describe Patient, type: :model do
  let(:doe) { build(:patient) }

  describe "ActiveModel validations" do
    # basic validations
    [:first_name, :last_name, :birthdate].each do |attr|
      it { expect(doe).to validate_presence_of(attr) }
    end

    # it { expect(doe).not_to allow_value(nil).for(:agency_id) }
    it { expect(doe).to define_enum_for(:sex).with_values([:male, :female]) }
  end
end
