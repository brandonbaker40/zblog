require 'rails_helper'

RSpec.describe Import, type: :model do

  let(:i) { build(:import) }

  describe "ActiveStorage validations" do
    it { expect(i).to validate_attached_of(:file) } # false passage
  end
end
