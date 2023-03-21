require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'Association Test' do
    it { should belong_to(:author) }
    it { should have_many(:contracts).dependent(:destroy) }
    it { should have_many(:contracts).through(:contract_groups) }
  end

  describe 'Validation Test' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:icon) }
  end
end
